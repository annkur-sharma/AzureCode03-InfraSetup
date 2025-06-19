variable "child_sql_database_name" {
  description = "The name of the SQL Database Name."
  type = string
}

variable "child_resource_location" {
  description = "The Azure region where the virtual machine will be created."
  type        = string
}

variable "child_sql_server_name" {
  description = "The name of the SQL server."
  type        = string
}

variable "child_resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created."
  type        = string
}