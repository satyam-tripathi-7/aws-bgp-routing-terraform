resource "aws_route" "vpc_1_to_vpc_2" {
  route_table_id         = data.terraform_remote_state.network.outputs.VPC1_private_route_table_id[0]
  destination_cidr_block = data.terraform_remote_state.network.outputs.vpc2_cidr_block  # VPC-2 CIDR
  network_interface_id   = module.router-1.primary_network_interface_id
}

resource "aws_route" "vpc_2_to_vpc_1" {
  route_table_id         = data.terraform_remote_state.network.outputs.VPC2_private_route_table_id[0]
  destination_cidr_block = data.terraform_remote_state.network.outputs.vpc1_cidr_block  # VPC-1 CIDR
  network_interface_id   = module.router-2.primary_network_interface_id
}