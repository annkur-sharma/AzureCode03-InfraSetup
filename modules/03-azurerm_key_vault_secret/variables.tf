variable "child_resource_group_name_key_vault" {
    type = string
    description = "The name of the resource group for Key Vault."
}

variable "child_key_vault_name" {
    type = string
    description = "The name of the key vault."
}

variable "child_key_vault_secret_vm_password_key" {
  type        = string
  description = "Key for VM password"
}

variable "child_key_vault_secret_vm_password_value" {
    type = string
    description = "Secret Value for key : Key-VMPassword"
    sensitive = true
}

variable "child_key_vault_secret_sql_password_key" {
  type        = string
  description = "Key for SQL password"
}

variable "child_key_vault_secret_sql_password_value" {
    type = string
    description = "Secret Value for key : Key-SQLPassword"
    sensitive = true
}