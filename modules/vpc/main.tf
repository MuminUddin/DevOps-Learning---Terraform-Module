resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "wp-vpc"
      Project = "terraform-assignment1"
      Environment = "dev"
    }
}

resource "aws_subnet" "public" {
    availability_zone = var.availability_zone
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags = {
      Name = "wp-subnet"
      Project = "terraform-assignment1"
      Environment = "dev"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id  
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route { 
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.public.id
  
}