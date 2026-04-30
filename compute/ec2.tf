module "router-1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"
  name = "router-1"
  ami = data.aws_ami.AMILinux.id
  instance_type = var.instance_type
  key_name      = var.key
  monitoring    = true
  subnet_id     = data.terraform_remote_state.network.outputs.vpc1_public_subnets[0]
  vpc_security_group_ids = [module.SG1.SG_allow_ssh_and_icmp_from_internet_id, aws_security_group.allow_bgp_gre_vpc1.id]
  source_dest_check = false
  create_security_group = false
  user_data = templatefile("./scripts/router.sh", {
  peer_eip        = aws_eip.router-2.public_ip
  local_tunnel_ip = "169.254.0.1/30"
  peer_tunnel_ip  = "169.254.0.2"
  local_asn       = 65001
  peer_asn        = 65002
  local_vpc_cidr  = data.terraform_remote_state.network.outputs.vpc1_cidr_block
  private_subnet  = data.terraform_remote_state.network.outputs.vpc1_private_subnets_cidr_block[0]
  private_gw      = cidrhost(data.terraform_remote_state.network.outputs.vpc1_public_subnets_cidr_block[0], 1)
})
  

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "router-2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"
  name = "router-2"
  ami = data.aws_ami.AMILinux.id
  instance_type = var.instance_type
  key_name      = var.key
  monitoring    = true
  subnet_id     = data.terraform_remote_state.network.outputs.vpc2_public_subnets[0]
  vpc_security_group_ids = [module.SG2.SG_allow_ssh_and_icmp_from_internet_id, aws_security_group.allow_bgp_gre_vpc2.id]
  source_dest_check = false
  create_security_group = false
  user_data = templatefile("./scripts/router.sh", {
  peer_eip        = aws_eip.router-1.public_ip
  local_tunnel_ip = "169.254.0.2/30"
  peer_tunnel_ip  = "169.254.0.1"
  local_asn       = 65002
  peer_asn        = 65001
  local_vpc_cidr  = data.terraform_remote_state.network.outputs.vpc2_cidr_block
  private_subnet  = data.terraform_remote_state.network.outputs.vpc2_private_subnets_cidr_block[0]
  private_gw      = cidrhost(data.terraform_remote_state.network.outputs.vpc2_public_subnets_cidr_block[0], 1)
})

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "private-1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"
  name = "private-1"
  ami = data.aws_ami.AMILinux.id
  instance_type = var.instance_type
  key_name      = var.key
  monitoring    = true
  subnet_id     = data.terraform_remote_state.network.outputs.vpc1_private_subnets[0]
  vpc_security_group_ids = [module.SG1.SG_allow_ssh_and_icmp_from_cidr_id]
  create_security_group = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "private-2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"
  name = "private-2"
  ami = data.aws_ami.AMILinux.id
  instance_type = var.instance_type
  key_name      = var.key
  monitoring    = true
  subnet_id     = data.terraform_remote_state.network.outputs.vpc2_private_subnets[0]
  vpc_security_group_ids = [module.SG2.SG_allow_ssh_and_icmp_from_cidr_id]
  create_security_group = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

## AMI data source
data "aws_ami" "AMILinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


