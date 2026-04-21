output "SG_allow_ssh_and_icmp_from_internet_id" {
    description = "SG ID of allow_ssh_and_icmp_from_internet"
    value = aws_security_group.allow_ssh_and_icmp_from_internet.id
}

output "SG_allow_ssh_and_icmp_from_cidr_id" {
    description = "SG ID of allow_ssh_and_icmp_from_cidr"
    value = aws_security_group.allow_ssh_and_icmp_from_cidr.id
}