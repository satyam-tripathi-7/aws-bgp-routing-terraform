variable "region" {
    description = "region where terraform resource will be created"
    default = null
}

variable "profile" {
    description = "profile to be user to create terraform resources"
    default = null
}

variable "instance_type" {
    description = "type of ec2 instance to be created"
    default = null
}

variable "key" {
        description = "SSH key" 
        default = null
}