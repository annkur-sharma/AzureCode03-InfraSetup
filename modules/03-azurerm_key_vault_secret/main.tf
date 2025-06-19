resource "azurerm_key_vault_secret" "child_key_vault_secret_vm_password_value" {
  name         = var.child_key_vault_secret_vm_password_key
  value        = var.child_key_vault_secret_vm_password_value
  key_vault_id = data.azurerm_key_vault.get_child_key_vault.id
}

resource "azurerm_key_vault_secret" "child_key_vault_secret_sql_password_value" {
  name         = var.child_key_vault_secret_sql_password_key
  value        = var.child_key_vault_secret_sql_password_value
  key_vault_id = data.azurerm_key_vault.get_child_key_vault.id
}


