module "vpc" {
  source = "./modules/vpc"
  availability_zone = var.availability_zone
  vpc_cidr = var.vpc_cidr
}

module "ec2" {
  source = "./modules/ec2"
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.vpc.subnet_id
  security_group_id = [module.security.security_group_id]
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}


# resource "aws_vpc" "main" {
#     cidr_block = var.vpc_cidr
#     tags = {
#       Name = "wp-vpc"
#       Project = "terraform-assignment1"
#       Environment = "dev"
#     }
# }

# resource "aws_subnet" "public" {
#     availability_zone = var.availability_zone
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.1.0/24"
#     map_public_ip_on_launch = true
#     tags = {
#       Name = "wp-subnet"
#       Project = "terraform-assignment1"
#       Environment = "dev"
#     }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id  
# }

# resource "aws_route_table" "rt" {
#   vpc_id = aws_vpc.main.id
#   route { 
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }
# }

# resource "aws_route_table_association" "rta" {
#   route_table_id = aws_route_table.rt.id
#   subnet_id = aws_subnet.public.id
  
# }

# resource "aws_instance" "wordpress_server" {
#   ami = var.ami
#   instance_type = var.instance_type
#   subnet_id = aws_subnet.public.id
#   vpc_security_group_ids = [aws_security_group.sg.id]
#   key_name = "CoderCo"
#   tags = {
#     Name = "wp-instance"
#     Project = "terraform-assignment1"
#     Environment = "dev"
#   }
#   user_data = <<-CLOUD
# #cloud-config
# package_update: true
# packages:
#   - apache2
#   - php
#   - php-mysql
#   - mariadb-server
#   - curl
#   - tar

# runcmd:
#   # Start and enable services
#   - systemctl enable --now apache2
#   - systemctl enable --now mariadb

#   # Create WordPress database (uses MariaDB root socket auth on Ubuntu)
#   - mysql -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"

#   # Download and unpack WordPress into the web root
#   - curl -L -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
#   - tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1

#   # Set permissions
#   - chown -R www-data:www-data /var/www/html
#   - find /var/www/html -type d -exec chmod 755 {} \;
#   - find /var/www/html -type f -exec chmod 644 {} \;

#   # Configure wp-config.php (basic lab setup)
#   - cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
#   - sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
#   - sed -i "s/username_here/root/" /var/www/html/wp-config.php
#   - sed -i "s/password_here//" /var/www/html/wp-config.php

#   # Optional: fetch unique auth salts for better security
#   - sed -i "/AUTH_KEY/d;/SECURE_AUTH_KEY/d;/LOGGED_IN_KEY/d;/NONCE_KEY/d;/AUTH_SALT/d;/SECURE_AUTH_SALT/d;/LOGGED_IN_SALT/d;/NONCE_SALT/d" /var/www/html/wp-config.php
#   - curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/html/wp-config.php

#   # Make sure Apache is serving index.php
#   - a2enmod php* || true
#   - systemctl restart apache2
# CLOUD

# }

# resource "aws_security_group" "sg" {
#   vpc_id = aws_vpc.main.id
# }

# resource "aws_vpc_security_group_ingress_rule" "sg_http" {
#   ip_protocol = "tcp"
#   security_group_id = aws_security_group.sg.id
#   cidr_ipv4 = "0.0.0.0/0"
#   from_port = 80
#   to_port = 80
# }

# resource "aws_vpc_security_group_ingress_rule" "sg_https" {
#   ip_protocol = "tcp"
#   security_group_id = aws_security_group.sg.id
#   cidr_ipv4 = "0.0.0.0/0"
#   from_port = 443
#   to_port = 443
# }

# resource "aws_vpc_security_group_ingress_rule" "ssh" {
#   ip_protocol = "tcp"
#   security_group_id = aws_security_group.sg.id
#   cidr_ipv4 = var.public_ip
#   from_port = 22
#   to_port = 22
# }

# resource "aws_vpc_security_group_egress_rule" "sg_out" {
#   ip_protocol = "-1"
#   security_group_id = aws_security_group.sg.id
#   cidr_ipv4   = "0.0.0.0/0"
# }