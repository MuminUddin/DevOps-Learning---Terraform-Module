variable "instance_type" {
    type = string
}

variable "ami" {
    type = string
}

variable "availability_zone" {
    type = string
}

# variable "public_ip" {
#     description = "public ip for ec2"
#     type = string
# }

variable "vpc_cidr" {
    description = "cidr block for the vpc"
    type = string
}

# output "subnet_id" {
#     description = "id for public subnet"
#     value = aws_subnet.public.id
# }

# output "instance_id" {
#     description = "id for the ec2 instance"  
#     value = aws_instance.wordpress_server.id
# }

# output "route_table_id" {
#     description = "id for route table"
#     value = aws_route_table.rt.id  
# }

# output "security_group_id" {
#     description = "id for security group"
#     value = aws_security_group.sg.id
# }