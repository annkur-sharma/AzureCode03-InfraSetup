data "azurerm_network_interface" "get_child_nic" {
  name                = var.child_nic_name
  resource_group_name = var.child_resource_group_name
}

data "azurerm_key_vault" "get_azure_key_vault" {
  name                = var.child_key_vault_name
  resource_group_name = var.child_resource_group_name_key_vault
}

data "azurerm_key_vault_secret" "get_key_vault_secret_vm_password" {
  name         = var.child_key_vault_secret_vm_password_key
  key_vault_id = data.azurerm_key_vault.get_azure_key_vault.id
}