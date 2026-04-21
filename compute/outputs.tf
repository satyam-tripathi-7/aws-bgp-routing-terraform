
output "router-1_private_ip" {
    description = "private ip of router-1 instance"
    value = module.router-1.private_ip
}

output "router-2_private_ip" {
    description = "private ip of router-2 instance"
    value = module.router-2.private_ip
}

output "private-1_private_ip" {
    description = "private ip of private-1 instance"
    value = module.private-1.private_ip
}

output "private-2_private_ip" {
    description = "private ip of private-2 instance"
    value = module.private-2.private_ip
}



output "router-1_public_ip" {
    description = "public ip of router-1 instance"
    value = aws_eip.router-1.public_ip
}

output "router-2_public_ip" {
    description = "public ip of router-2 instance"
    value = aws_eip.router-2.public_ip
}