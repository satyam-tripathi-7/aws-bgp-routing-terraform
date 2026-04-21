## to be applied on router
## allow ICMP and SSH from internet

resource "aws_security_group" "allow_ssh_and_icmp_from_internet" {
  name        = "allow_ssh_and_icmp_from_internet"
  description = "Allow SSH and ICMP from internet"
  vpc_id      = var.vpc_id
}

## ssh ingree
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_internet" {
  security_group_id = aws_security_group.allow_ssh_and_icmp_from_internet.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

## ICMP ingress
resource "aws_vpc_security_group_ingress_rule" "allow_icmp_internet" {
  security_group_id = aws_security_group.allow_ssh_and_icmp_from_internet.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1
}

##to be applied on private instance
## allow ICMP and SSH from VPC CIDR

resource "aws_security_group" "allow_ssh_and_icmp_from_cidr" {
  name        = "allow_ssh_and_icmp_from_cidr"
  description = "Allow SSH and ICMP from VPCs"
  vpc_id      = var.vpc_id
}

## ssh ingree
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_cidr" {
  security_group_id = aws_security_group.allow_ssh_and_icmp_from_cidr.id
  cidr_ipv4         = var.vpc_cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

## ICMP ingress
resource "aws_vpc_security_group_ingress_rule" "allow_icmp_cidr" {
  security_group_id = aws_security_group.allow_ssh_and_icmp_from_cidr.id
  cidr_ipv4         = var.vpc_cidr_block
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp_from_peer_vpc" {
    security_group_id = aws_security_group.allow_ssh_and_icmp_from_cidr.id
    for_each = toset(var.vpc_peer_cidr)
    cidr_ipv4 = each.value
    from_port         = -1
    ip_protocol       = "icmp"
    to_port           = -1
  
}

## egress rules: allow all outbound
locals {
  SGs = {
    allow_ssh_and_icmp_from_internet = aws_security_group.allow_ssh_and_icmp_from_internet.id
    allow_ssh_and_icmp_from_cidr = aws_security_group.allow_ssh_and_icmp_from_cidr.id
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  for_each = local.SGs
  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}