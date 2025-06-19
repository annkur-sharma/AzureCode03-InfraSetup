## ✅ Update this with your own subscription ID.
main_provider_subscription_id = "00000000-0000-0000-0000-000000000000" # ✅ Update this with your own subscription ID.

## ✅ Update this with your own Azure region.
root_resource_location = "France Central"

## ✅ Update this with your own VNet address space.
root_vnet_address_space = ["46.87.0.0/24"]

## ✅ Update this with your own subnet address prefixes.
root_subnet_address_prefixes = ["46.87.0.0/28"]

## ✅ Update this with your own Username for VM
root_virtual_machine_username = "VMUser1"

## ✅ Update this with your own Username for SQL Server
root_sql_server_username = "SQLUser1"

######################################################################################

## ⚠️ Do not update below values. User Prefix/Suffix is automatically added to the name.
root_resource_group_name               = "rg"          # Resource Group
# root_resource_group_name_key_vault     = "rg-KeyVault" # Resource Group for Key Vault
root_key_vault_suffix                  = "KeyVault"    # Key Vault suffix
root_key_vault_secret_vm_password_key  = "VMPassword"  # VM Password Key in Key Vault
root_key_vault_secret_sql_password_key = "SQLPassword" # SQL Password Key in Key Vault
root_key_vault_name                    = "KeyVault"    # Key Vault Name
root_vnet_name                         = "VNet"        # VNet Name
root_subnet_name                       = "Subnet"      # Subnet Name
root_nsg_name                          = "NSG"         # NSG Name
root_public_Ip_name                    = "PublicIP"    # Public IP Name
root_nic_name                          = "NIC"         # NIC Name
root_ip_config_name                    = "IPConfig"    # IP Config Name
root_virtual_machine_name              = "VM"          # VM Name
root_sql_server_name                   = "sqlserver"   # SQL Server Name
root_sql_database_name                 = "sqldb"       # SQL Database Name
