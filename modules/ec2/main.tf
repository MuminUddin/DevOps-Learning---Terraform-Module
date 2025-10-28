resource "aws_instance" "wordpress_server" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_group_id
  key_name = "CoderCo"
  tags = {
    Name = "wp-instance"
    Project = "terraform-assignment1"
    Environment = "dev"
  }
  user_data = <<-CLOUD
#cloud-config
package_update: true
packages:
  - apache2
  - php
  - php-mysql
  - mariadb-server
  - curl
  - tar

runcmd:
  # Start and enable services
  - systemctl enable --now apache2
  - systemctl enable --now mariadb

  # Create WordPress database (uses MariaDB root socket auth on Ubuntu)
  - mysql -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"

  # Download and unpack WordPress into the web root
  - curl -L -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
  - tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1

  # Set permissions
  - chown -R www-data:www-data /var/www/html
  - find /var/www/html -type d -exec chmod 755 {} \;
  - find /var/www/html -type f -exec chmod 644 {} \;

  # Configure wp-config.php (basic lab setup)
  - cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
  - sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
  - sed -i "s/username_here/root/" /var/www/html/wp-config.php
  - sed -i "s/password_here//" /var/www/html/wp-config.php

  # Optional: fetch unique auth salts for better security
  - sed -i "/AUTH_KEY/d;/SECURE_AUTH_KEY/d;/LOGGED_IN_KEY/d;/NONCE_KEY/d;/AUTH_SALT/d;/SECURE_AUTH_SALT/d;/LOGGED_IN_SALT/d;/NONCE_SALT/d" /var/www/html/wp-config.php
  - curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/html/wp-config.php

  # Make sure Apache is serving index.php
  - a2enmod php* || true
  - systemctl restart apache2
CLOUD

}