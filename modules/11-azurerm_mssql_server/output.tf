output "child_output_sql_server_username" {
  description = "Virtual Machine Name: Username: "
  value = azurerm_mssql_server.child_sqlserver.administrator_login
}