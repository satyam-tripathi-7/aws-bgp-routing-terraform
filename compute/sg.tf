module "SG1" {

    source = "../modules/security-group"
    vpc_cidr_block = data.terraform_remote_state.network.outputs.vpc1_cidr_block
    vpc_id = data.terraform_remote_state.network.outputs.vpc1_id
    vpc_peer_cidr = [data.terraform_remote_state.network.outputs.vpc2_cidr_block]
}

module "SG2" {

    source = "../modules/security-group"
    vpc_cidr_block = data.terraform_remote_state.network.outputs.vpc2_cidr_block
    vpc_id = data.terraform_remote_state.network.outputs.vpc2_id
    vpc_peer_cidr = [data.terraform_remote_state.network.outputs.vpc1_cidr_block]
}

##BGP 179 and GRE 47 SG
##sg for router 1
resource "aws_security_group" "allow_bgp_gre_vpc1" {
  name        = "allow_179_vpc1"
  description = "Allow port 179 for BGP peering"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc1_id
}


resource "aws_vpc_security_group_ingress_rule" "allow_179_vpc1" {
  security_group_id = aws_security_group.allow_bgp_gre_vpc1.id
  cidr_ipv4         = "${aws_eip.router-2.public_ip}/32"
  from_port         = 179
  ip_protocol       = "tcp"
  to_port           = 179
}

resource "aws_vpc_security_group_ingress_rule" "allow_gre_vpc1" {
  security_group_id = aws_security_group.allow_bgp_gre_vpc1.id
  cidr_ipv4         = "${aws_eip.router-2.public_ip}/32"
  ip_protocol       = "47"
}

##sg for router 2
resource "aws_security_group" "allow_bgp_gre_vpc2" {
  name        = "allow_179_vpc2"
  description = "Allow port 179 for BGP peering"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc2_id
}



resource "aws_vpc_security_group_ingress_rule" "allow_179_vpc2" {
  security_group_id = aws_security_group.allow_bgp_gre_vpc2.id
  cidr_ipv4         = "${aws_eip.router-1.public_ip}/32"
  from_port         = 179
  ip_protocol       = "tcp"
  to_port           = 179
}

resource "aws_vpc_security_group_ingress_rule" "allow_gre_vpc2" {
  security_group_id = aws_security_group.allow_bgp_gre_vpc2.id
  cidr_ipv4         = "${aws_eip.router-1.public_ip}/32"
  ip_protocol       = "47"
}