variable "child_resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created."
  type        = string
}

variable "child_resource_location" {
  description = "The Azure region where the virtual machine will be created."
  type        = string
}

variable "child_sql_server_name" {
  description = "The name of the SQL server."
  type        = string
}

variable "child_sql_server_username" {
  description = "The username for the SQL Server."
  type        = string
}

variable "child_resource_group_name_key_vault" {
    type = string
    description = "The name of the resource group for Key Vault."
}

variable "child_key_vault_name" {
    type = string
    description = "The name of the key vault."
}

variable "child_key_vault_secret_sql_password_key" {
  type        = string
  description = "Key for SQL password"
}
