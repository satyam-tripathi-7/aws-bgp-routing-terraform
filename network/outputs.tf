output "vpc1_id" {
    description = "VPC 1 ID"
    value = module.vpc1.vpc_id  
}

output "vpc1_cidr_block" {
    description = "VPC 1 CIDR"
    value = module.vpc1.vpc_cidr_block
}

output "vpc2_id" {
    description = "VPC 2 ID"
    value = module.vpc2.vpc_id  
}

output "vpc2_cidr_block" {
    description = "VPC 2 CIDR"
    value = module.vpc2.vpc_cidr_block
}

output "vpc1_public_subnets" {
    description = "vpc1_public_subnets"
    value = module.vpc1.public_subnets
}
output "vpc1_private_subnets" {
    description = "vpc1_private_subnets"
    value = module.vpc1.private_subnets
}

output "vpc2_public_subnets" {
    description = "vpc2_public_subnets"
    value = module.vpc2.public_subnets
}
output "vpc2_private_subnets" {
    description = "vpc2_private_subnets"
    value = module.vpc2.private_subnets
}

output "vpc1_public_subnets_cidr_block" {
    description = "vpc1_public_subnets_cidr"
    value = module.vpc1.public_subnets_cidr_blocks
}

output "vpc2_public_subnets_cidr_block" {
    description = "vpc2_public_subnets_cidr"
    value = module.vpc2.public_subnets_cidr_blocks
}

output "vpc1_private_subnets_cidr_block" {
    description = "vpc1_private_subnets_cidr"
    value = module.vpc1.private_subnets_cidr_blocks
}

output "vpc2_private_subnets_cidr_block" {
    description = "vpc2_private_subnets_cidr"
    value = module.vpc2.private_subnets_cidr_blocks
}

output "VPC1_private_route_table_id" {
    description = "VPC1 private route table id"
    value = module.vpc1.private_route_table_ids
  
}

output "VPC2_private_route_table_id" {
    description = "VPC2 private route table id"
    value = module.vpc2.private_route_table_ids
  
}