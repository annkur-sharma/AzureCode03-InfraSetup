resource "null_resource" "set_execution_policy" {
  provisioner "local-exec" {
    command = "Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force"
    interpreter = ["powershell", "-Command"]
  }
}

data "external" "get_my_ip" {
  depends_on = [null_resource.set_execution_policy]
  program    = ["powershell", 
                "-ExecutionPolicy", "Bypass",
                "-File", "${path.module}/../../INFRA01/scripts/get_ip.ps1"]
}

data "azurerm_mssql_server" "get_child_sql_server" {
  depends_on          = [azurerm_mssql_server.child_sqlserver]
  name                = var.child_sql_server_name
  resource_group_name = var.child_resource_group_name
}

data "azurerm_key_vault" "get_azure_key_vault" {
  name                = var.child_key_vault_name
  resource_group_name = var.child_resource_group_name_key_vault
}

data "azurerm_key_vault_secret" "get_key_vault_secret_sql_password" {
  name         = var.child_key_vault_secret_sql_password_key
  key_vault_id = data.azurerm_key_vault.get_azure_key_vault.id
}

