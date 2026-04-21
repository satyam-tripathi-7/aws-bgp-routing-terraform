##eip for router-1
resource "aws_eip" "router-1" {
  domain   = "vpc"
}

resource "aws_eip_association" "eip_router1" {
  instance_id   = module.router-1.id
  allocation_id = aws_eip.router-1.id
}

##eip for router-2
resource "aws_eip" "router-2" {
  domain   = "vpc"
}

resource "aws_eip_association" "eip_router2" {
  instance_id   = module.router-2.id
  allocation_id = aws_eip.router-2.id
}