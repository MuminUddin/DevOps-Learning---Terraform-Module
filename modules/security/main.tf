resource "aws_security_group" "sg" {
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "sg_http" {
  ip_protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "sg_https" {
  ip_protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  ip_protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  cidr_ipv4 = "82.9.71.113/32"
  from_port = 22
  to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "sg_out" {
  ip_protocol = "-1"
  security_group_id = aws_security_group.sg.id
  cidr_ipv4   = "0.0.0.0/0"
}