resource "azurerm_mssql_database" "child_sql_database" {
  name         = var.child_sql_database_name
  server_id    = data.azurerm_mssql_server.get_child_sql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2 # Size in GB
  sku_name     = "S0"
  enclave_type = "VBS"
}