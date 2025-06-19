variable "main_provider_subscription_id" {
  type        = string
  description = "The Azure subscription ID"
}

# The prefix must be exactly 8 alphanumeric characters, starting with a letter (A–Z or a–z).
# The prefix can contain letters (A–Z, a–z) and numbers (0–9).
# ✅ Example Valid Inputs
# abc123de    ✅
# X9y8Z7q1    ✅

# ❌ Invalid Inputs
# 123abcdz    ❌ starts with a number
# abc@1234    ❌ contains special character
# abc123      ❌ less than 8 characters
# abcdefgh9   ❌ too long
variable "user_prefix" {
  type        = string
  description = "########################################################################################### \n Enter an 8-character alphanumeric prefix for the resource names. \n\n ✅ Example Valid Inputs:\n >> eagle987 ✅ (valid) \n >> lion1234 ✅ (valid) \n\n ❌ Invalid Inputs: \n >> 123abcdz  ❌ (starts with a number) \n >> abc123    ❌ (less than 8 characters) \n >> abcdefgh9 ❌ (too long)"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9]{7}$", var.user_prefix))
    error_message = "Prefix must be exactly 8 alphanumeric characters, starting with a letter (A–Z or a–z)."
  }
}

variable "root_key_vault_secret_vm_password_key" {
  type        = string
  description = "Key for VM Password."
}

# The value must be 8 to 12 alphanumeric characters.
# The value can contain letters (A–Z, a–z), numbers (0–9) and special characters (@, !).
# ✅ Example Valid Inputs
# Eagle98!      ✅
# Lion@12345    ✅

# ❌ Invalid Inputs
# abc123          ❌ less than 8 characters
# abcijklmngh98   ❌ too long, more than 12 characters
variable "root_key_vault_secret_vm_password_value" {
  type        = string
  description = "########################################################################################### \n Enter password for : VM-Username \n Enter 8 to 12 character alphanumeric Secret. \n\n ✅ Example Valid Inputs:\n >> Eagle98!   ✅ (valid, 8-12 characters) \n >> Lion@12345 ✅ (valid, 8-12 characters) \n >> ✅ Allowed special characters: @ ! \n\n ❌ Invalid Inputs: \n >> abc123        ❌ (less than 8 characters) \n >> abcijklmngh98 ❌ (too long, more than 12 characters)"

  validation {
    condition     = can(regex("^[a-zA-Z0-9@!]{8,12}$", var.root_key_vault_secret_vm_password_value))
    error_message = "Password must be 8 to 12 alphanumeric characters (A–Z or a–z or 0-9) and special characters (@ or !)."
  }
}

variable "root_key_vault_secret_sql_password_key" {
  type        = string
  description = "Key for SQL Password."
}

# The value must be 8 to 12 alphanumeric characters.
# The value can contain letters (A–Z, a–z), numbers (0–9) and special characters (@, !).
# ✅ Example Valid Inputs
# Eagle98!      ✅
# Lion@12345    ✅

# ❌ Invalid Inputs
# abc123          ❌ less than 8 characters
# abcijklmngh98   ❌ too long, more than 12 characters
variable "root_key_vault_secret_sql_password_value" {
  type        = string
  description = "########################################################################################### \n Enter password for : SQL-Username \n Enter 8 to 12 character alphanumeric Secret. \n\n ✅ Example Valid Inputs:\n >> Eagle98!   ✅ (valid, 8-12 characters) \n >> Lion@12345 ✅ (valid, 8-12 characters) \n >> ✅ Allowed special characters: @ ! \n\n ❌ Invalid Inputs: \n >> abc123        ❌ (less than 8 characters) \n >> abcijklmngh98 ❌ (too long, more than 12 characters)"

  validation {
    condition     = can(regex("^[a-zA-Z0-9@!]{8,12}$", var.root_key_vault_secret_sql_password_value))
    error_message = "Password must be 8 to  12 alphanumeric characters (A–Z or a–z or 0-9) and special characters (@ or !)."
  }
}

variable "root_resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "root_resource_location" {
  type        = string
  description = "The Azure region where the resource group will be created."
}

variable "root_key_vault_name" {
  type        = string
  description = "The name of the key vault."
}

variable "root_key_vault_suffix"{
  type        = string
  description = "Key vault suffix."
}

variable "root_vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "root_vnet_address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
}

variable "root_subnet_name" {
  type        = string
  description = "The name of the subnet."
}

variable "root_subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the subnet."
}

variable "root_nsg_name" {
  type        = string
  description = "value of the name of the network security group."
}

variable "root_public_Ip_name" {
  type        = string
  description = "The name of the public IP address."
}

variable "root_nic_name" {
  type        = string
  description = "The name of the network interface."
}

variable "root_ip_config_name" {
  type        = string
  description = "The name of the IP configuraton"
}

variable "root_virtual_machine_name" {
  type        = string
  description = "The name of the virtual machine."
}

variable "root_virtual_machine_username" {
  type        = string
  description = "The username for the virtual machine."
}

variable "root_sql_server_name" {
  description = "The name of the SQL server."
  type        = string
}

variable "root_sql_server_username" {
  description = "The username for the SQL Server."
  type        = string
}

variable "root_sql_database_name" {
  description = "The name of the SQL Database."
  type        = string
}
