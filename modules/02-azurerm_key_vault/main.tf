data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "child_key_vault" {
  name                        = var.child_key_vault_name
  location                    = var.child_resource_location
  resource_group_name         = var.child_resource_group_name_key_vault
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "Update", "List", "Delete"
    ]

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Purge"
    ]

    storage_permissions = [
      "Get", "Set", "Update", "List", "Delete"
    ]
  }
}

