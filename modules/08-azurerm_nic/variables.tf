variable "child_resource_group_name" {
  description = "The name of the resource group where the NIC will be created."
  type        = string
}

variable "child_resource_location" {
  description = "The Azure region where the NIC will be created."
  type        = string
}

variable "child_nic_name" {
  description = "The name of the network interface."
  type        = string
}

variable "child_ip_config_name" {
  description = "The name of the IP configuraton"
  type        = string
}

variable "child_public_Ip_name" {
  description = "The name of the public IP address."
  type        = string
}

variable "child_subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "child_vnet_name" {
  description = "The name of the virtual network."
  type        = string
}
