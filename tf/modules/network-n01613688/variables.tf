variable "location" {
  description = "The location/region of the resource"
}

variable "resource_group_name" {
  description = "The name of the resource group"
}

variable "vnet_name_prefix" {
  description = "The name of the virtual network"
}

variable "subnet_name_prefix" {
  description = "The name of the subnet"
}

variable "security_group_name_prefix" {
  description = "The name of the network security group"
}

variable "address_space" {
  description = "The address space that is used the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_space" {
  description = "The address space that is used the subnet"
  default     = ["10.0.1.0/24"]
}

variable "tags" {}