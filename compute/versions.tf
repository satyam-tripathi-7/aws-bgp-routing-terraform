
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend   "s3"  {}
  
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = var.profile
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "satyam-terraform-backend"
    key = "bgp-project/network/terraform.tfstate"
    region = "ap-south-1"
  }
}

