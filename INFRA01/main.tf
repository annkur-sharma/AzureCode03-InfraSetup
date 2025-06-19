resource "random_string" "random_id_rg" {
  length  = 8
  upper   = true
  lower   = true
  numeric = true
  special = false
}

resource "random_string" "random_id_key_vault" {
  length  = 5
  upper   = true
  lower   = true
  numeric = true
  special = false
}

module "module_resource_group" {
  source                    = "../modules/01-azurerm_resource_group"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
}

module "module_resource_group_key_vault" {
  depends_on                = [random_string.random_id_rg, random_string.random_id_key_vault ,module.module_resource_group]
  source                    = "../modules/01-azurerm_resource_group"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}-${var.root_key_vault_suffix}-${random_string.random_id_rg.result}"
  child_resource_location   = var.root_resource_location
}

module "module_key_vault" {
  depends_on                          = [module.module_resource_group_key_vault, random_string.random_id_key_vault]
  source                              = "../modules/02-azurerm_key_vault"
  child_key_vault_name                = "${var.root_key_vault_name}-${local.formatted_user_prefix}-${random_string.random_id_key_vault.result}"
  child_resource_group_name_key_vault = "${var.root_resource_group_name}-${local.formatted_user_prefix}-${var.root_key_vault_suffix}-${random_string.random_id_rg.result}"
  child_resource_location             = var.root_resource_location
}

module "module_azurerm_key_vault_secret" {
  depends_on                                = [module.module_key_vault]
  source                                    = "../modules/03-azurerm_key_vault_secret"
  child_key_vault_name                      = "${var.root_key_vault_name}-${local.formatted_user_prefix}-${random_string.random_id_key_vault.result}"
  child_resource_group_name_key_vault       = "${var.root_resource_group_name}-${local.formatted_user_prefix}-${var.root_key_vault_suffix}-${random_string.random_id_rg.result}"
  child_key_vault_secret_vm_password_key    = "${var.root_key_vault_secret_vm_password_key}-${local.formatted_user_prefix}"
  child_key_vault_secret_vm_password_value  = var.root_key_vault_secret_vm_password_value
  child_key_vault_secret_sql_password_key   = "${var.root_key_vault_secret_sql_password_key}-${local.formatted_user_prefix}"
  child_key_vault_secret_sql_password_value = var.root_key_vault_secret_sql_password_value
}

module "module_virtual_network" {
  depends_on                = [module.module_resource_group, module.module_key_vault, module.module_azurerm_key_vault_secret]
  source                    = "../modules/04-azurerm_vnet"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_vnet_name           = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_vnet_address_space  = var.root_vnet_address_space
}

module "module_subnet" {
  depends_on                    = [module.module_virtual_network]
  source                        = "../modules/05-azurerm_subnet"
  child_resource_group_name     = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_vnet_name               = "${local.formatted_user_prefix}-${var.root_vnet_name}"
  child_subnet_name             = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_subnet_address_prefixes = var.root_subnet_address_prefixes
}

module "module_nsg" {
  depends_on                = [module.module_subnet]
  source                    = "../modules/06-azurerm_nsg"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
  child_resource_location   = var.root_resource_location
}

module "module_public_ip" {
  depends_on                = [module.module_nsg]
  source                    = "../modules/07-azurerm_public_ip"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_public_Ip_name}"
  child_resource_location   = var.root_resource_location
}

module "module_nic" {
  depends_on                = [module.module_public_ip]
  source                    = "../modules/08-azurerm_nic"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location   = var.root_resource_location
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name}"
  child_ip_config_name      = "${local.formatted_user_prefix}-${var.root_ip_config_name}"
  child_public_Ip_name      = "${local.formatted_user_prefix}-${var.root_public_Ip_name}"
  child_subnet_name         = "${local.formatted_user_prefix}-${var.root_subnet_name}"
  child_vnet_name           = "${local.formatted_user_prefix}-${var.root_vnet_name}"
}

module "module_nic_nsg_association" {
  depends_on                = [module.module_nic]
  source                    = "../modules/09-azurerm_nic_nsg_association"
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_nic_name            = "${local.formatted_user_prefix}-${var.root_nic_name}"
  child_nsg_name            = "${local.formatted_user_prefix}-${var.root_nsg_name}"
}

module "module_virtual_machine" {
  depends_on                             = [module.module_nic_nsg_association]
  source                                 = "../modules/10-azurerm_virtual_machine"
  child_resource_group_name              = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location                = var.root_resource_location
  child_virtual_machine_name             = "${local.formatted_user_prefix}-${var.root_virtual_machine_name}"
  child_virtual_machine_username         = var.root_virtual_machine_username
  child_nic_name                         = "${local.formatted_user_prefix}-${var.root_nic_name}"
  child_key_vault_name                   = "${var.root_key_vault_name}-${local.formatted_user_prefix}-${random_string.random_id_key_vault.result}"
  child_resource_group_name_key_vault    = "${var.root_resource_group_name}-${local.formatted_user_prefix}-${var.root_key_vault_suffix}-${random_string.random_id_rg.result}"
  child_key_vault_secret_vm_password_key = "${var.root_key_vault_secret_vm_password_key}-${local.formatted_user_prefix}"

}

module "module_sql_sqerver" {
  depends_on                              = [module.module_virtual_machine]
  source                                  = "../modules/11-azurerm_mssql_server"
  child_resource_group_name               = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
  child_resource_location                 = var.root_resource_location
  child_sql_server_name                   = "${local.formatted_user_prefix}-${var.root_sql_server_name}"
  child_sql_server_username               = var.root_sql_server_username
  child_key_vault_name                    = "${var.root_key_vault_name}-${local.formatted_user_prefix}-${random_string.random_id_key_vault.result}"
  child_resource_group_name_key_vault     = "${var.root_resource_group_name}-${local.formatted_user_prefix}-${var.root_key_vault_suffix}-${random_string.random_id_rg.result}"
  child_key_vault_secret_sql_password_key = "${var.root_key_vault_secret_sql_password_key}-${local.formatted_user_prefix}"
}

module "module_sql_database" {
  depends_on                = [module.module_sql_sqerver]
  source                    = "../modules/12-azurerm_mssql_database"
  child_sql_database_name   = "${local.formatted_user_prefix}-${var.root_sql_database_name}"
  child_sql_server_name     = "${local.formatted_user_prefix}-${var.root_sql_server_name}"
  child_resource_location   = var.root_resource_location
  child_resource_group_name = "${var.root_resource_group_name}-${local.formatted_user_prefix}"
}
