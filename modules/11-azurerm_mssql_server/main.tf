resource "azurerm_mssql_server" "child_sqlserver" {
  name                = var.child_sql_server_name
  resource_group_name = var.child_resource_group_name
  location            = var.child_resource_location

  version             = "12.0"
  minimum_tls_version = "1.2"

  # ⚠️ SQL Username is saved in the *.auto.tfvars file. User can change it before 'terraform apply'
  administrator_login = var.child_sql_server_username

  # ❌ Not recommended to use a hardcoded password in production.
  # 🔐 Use a Azure Key Vault in production environments.
  administrator_login_password = data.azurerm_key_vault_secret.get_key_vault_secret_sql_password.value  ## ✅ Captured from user input

  public_network_access_enabled = true
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  depends_on       = [azurerm_mssql_server.child_sqlserver]
  name             = "AllowMyHomeIP"
  server_id        = data.azurerm_mssql_server.get_child_sql_server.id
  start_ip_address = data.external.get_my_ip.result.public_ip
  end_ip_address   = data.external.get_my_ip.result.public_ip
}


