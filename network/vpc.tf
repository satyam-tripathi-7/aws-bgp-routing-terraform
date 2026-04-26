module "vpc1" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = "vpc1"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a",]
  private_subnets = ["10.0.1.0/24", ]
  public_subnets  = ["10.0.101.0/24" ]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  map_public_ip_on_launch = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "vpc2" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = "vpc2"
  cidr = "10.1.0.0/16"

  azs             = ["ap-south-1a"]
  private_subnets = ["10.1.1.0/24"]
  public_subnets  = ["10.1.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  map_public_ip_on_launch = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
