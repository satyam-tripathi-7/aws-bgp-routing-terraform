variable "vpc_id" {
    type = string
    default = null
    description = "VPC ID where SG will be created"
}

variable "vpc_cidr_block" {
    type = string
    default = null
    description = "cidr block of VPC where SG will be created"
}

variable "vpc_peer_cidr" {
    type = list(string)
    default = []
    description = "to allow ping from other VPC cidr block"
}