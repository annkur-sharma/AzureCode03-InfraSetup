variable "child_resource_group_name_key_vault" {
    type = string
    description = "The name of the resource group for Key Vault"
}

variable "child_resource_location" {
  type        = string
  description = "The Azure region where the resource group will be created"
}

variable "child_key_vault_name" {
    type = string
    description = "The name of the key vault."
}