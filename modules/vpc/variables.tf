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
