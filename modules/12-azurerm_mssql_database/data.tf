data "azurerm_mssql_server" "get_child_sql_server" {
  name                = var.child_sql_server_name
  resource_group_name = var.child_resource_group_name
}

