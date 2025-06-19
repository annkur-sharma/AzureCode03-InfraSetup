# AzureCode03-InfraSetup
AzureCode03-InfraSetup - To setup RG, Azure Key Vault, Vnet, Subnet, NIC, NSG, Public IP, VM, SQL Server, SQL Database, by dynamically providing user-prefix for the resources.

## Summary
#### Following resources are created on the Azure Colud environment by executing the code.
- Resource Group (for Key Vault)
  - Key Vault
    - SQL Username
    - SQL Password (User Input)
    - VM Username
    - VM Password (User Input)
- Resource Group (User Input for suffix)
  - Virtual Network (VNet)
  - Subnet
  - NSG
  - Public IP
  - NIC
  - NIC-NSG association
  - Virtual Machine
  - SQL Server
  - SQL Database

## Pre-Requisite
### ⚠️ Your user needs to have "Key Vault Administrator" rights ✅ in the subscription.

## Step 01 - Update backend configuration in the below mentioned file.
#### ✅ Update the values to be used to backend configuration.
#### ⚠️ This is a pre-requisite to execute the code.
#### ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.
````yaml
📝 .\INFRA01\backend-config-infra01.hcl

---------------------------------------------------------------------------------------------------
# ✅ Update the values to be used to backend configuration.
# ⚠️ This is pre-requisite to execute the code.
# ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.

resource_group_name  = <ENTER backend - Resource Group>          # Example: "rg-backend"
storage_account_name = <ENTER backend - Storage Account>         # Example: "storageaccount"
container_name       = <ENTER backend - Storage Container Name>  # Example: "storagecontainer"
key                  = <ENTER backend - State File Name>         # Example: "a.terraform.tfstate"
````

## Step 02 - Update azure subscription id in the below mentioned file.
#### ✅ Update this with your own subscription ID.
````yaml
📝 infra01.auto.tfvars

---------------------------------------------------------------------------------------------------
# ✅ Update this variable with your own subscription ID.
main_provider_subscription_id = "00000000-0000-0000-000000000000"
````

## Step 03 - Update variables in the below mentioned file.
#### All variables like Resource Group Location, VNet Address, Subnet Address needs to be updated.
````yaml
📝 infra01.auto.tfvars

---------------------------------------------------------------------------------------------------
# ✅ Update this variable with your own Azure region.
root_resource_location        = "France Central"

# ✅ Update this variable with your own VNet address space.
root_vnet_address_space       = ["46.87.0.0/24"]

# ✅ Update this variable with your own subnet address prefixes.
root_subnet_address_prefixes  = ["46.87.0.0/28"]

# ✅ Update this with your own Username for VM
root_virtual_machine_username = "VMUser1"  # 📌 This will be the username to access your VM.

# ✅ Update this with your own Username for SQL Server
root_sql_server_username      = "SQLUser1" # 📌 This will be the username to access your SQL Server.
````

## Step 04 - Following command needs to be executed to initialize the backend.
#### 💡 Run with -backend-config parameter, else the initialize will ask for user input.
````yaml
terraform init -backend-config='backend-config-infra01.hcl'
OR
terraform init -backend-config='backend-config-infra01.hcl' -upgrade
````

## Step 05 - Following commands can be used to proceed with infrastructure creation.
````yaml
terraform validate
terraform plan
````

## Step 06 - ❌ DO Not run terraform apply with auto-approve as user input is needed for user prefix.
#### ✅ Only run terrafom apply, as user input is need for dynamically creating resource names.
````yaml
terraform apply

# ❌ Do Not run terraform apply -auto-approve
````


# Execution
### User Input 1 - On running 'terraform apply', user is asked to provide SQL Server Password.
User is allowed to enter 8-12 alphanumeric characters and allowed special characters: @ !
````yaml
PS D:\TerraformCode\AzureCode01-InfraSetup\INFRA01> terraform apply

Acquiring state lock. This may take a few moments...

var.root_key_vault_secret_sql_password_value

  ###########################################################################################
   Enter password for : SQL-Username
   Enter 8 to 12 character alphanumeric Secret.

   ✅ Example Valid Inputs:
   >> Eagle98!   ✅ (valid, 8-12 characters)
   >> Lion@12345 ✅ (valid, 8-12 characters)
   >> ✅ Allowed special characters: @ !

   ❌ Invalid Inputs:
   >> abc123        ❌ (less than 8 characters)
   >> abcijklmngh98 ❌ (too long, more than 12 characters)

  Enter a value: SQL@12345  # ✅ User enters 8-12 character alphanumeric value
````

### User Input 2 - After providing 1st input, user is asked to provide VM Password.
User is allowed to enter 8-12 alphanumeric characters and allowed special characters: @ !
````yaml
var.root_key_vault_secret_vm_password_value

  ###########################################################################################
   Enter password for : VM-Username
   Enter 8 to 12 character alphanumeric Secret.

   ✅ Example Valid Inputs:
   >> Eagle98!   ✅ (valid, 8-12 characters)
   >> Lion@12345 ✅ (valid, 8-12 characters)
   >> ✅ Allowed special characters: @ !

   ❌ Invalid Inputs:
   >> abc123        ❌ (less than 8 characters)
   >> abcijklmngh98 ❌ (too long, more than 12 characters)

  Enter a value: VM@12345  # ✅ User enters 8-12 character alphanumeric value
````

### User Input 3 - After providing 2nd input, user is asked to provide Resource Prefix to be used to resource names.
User is allowed to enter 8 alphanumeric characters.
````yaml
var.user_prefix

  ###########################################################################################
   Enter an 8-character alphanumeric prefix for the resource names.

   ✅ Example Valid Inputs:
   >> eagle987 ✅ (valid)
   >> lion1234 ✅ (valid)

   ❌ Invalid Inputs:
   >> 123abcdz  ❌ (starts with a number)
   >> abc123    ❌ (less than 8 characters)
   >> abcdefgh9 ❌ (too long)

  Enter a value: fire0000  # ✅ User enters 8-12 character alphanumeric value
````

# Output
### 📤 Output values displayed to user after successful execution of the code.
````yaml
Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

Outputs:

root_output_key_vault_name                = "Key Vault Name: KeyVault-fire0000-M1I4K"    # 🔑 Key Vault Name
root_output_public_ip                     = "VM Public IP: 51.xxx.xxx.xx"                # 🌐 For information purpose only.
root_output_resource_group_name           = "Resource Group Name: rg-fire0000"           # 📦 Resource group created with 'rg-' as prefix and user input as suffix.
root_output_resource_group_name_key_vault = "Key Vault Resource Group Name: rg-fire0000-KeyVault-UgOtWb0o"
root_output_sql_server_username           = "SQL Server: Username: SQLUser1"             # 🔐 SQL Username
root_output_virtual_machine               = "Virtual Machine Name: fire0000-VM"          # 📦 Virtual Machine user input as prefix and '-VM' as suffix.
root_output_virtual_machine_username      = "SQL Server: Username: VMUser1"              # 🔐 VM Username
````

# 🧠 Troubleshooting errors
##  Error⚡ Provisioning is restricted in this region. Please choose a different region.
````yaml
Error: creating Server (Subscription: "00000000-0000-0000-0000-000000000000"
│ Resource Group Name: "rg-tommy123"
│ Server Name: "tommy123-sqlserver"): polling after CreateOrUpdate: polling failed: the Azure API returned the following error:
│
│ Status: "ProvisioningDisabled"
│ Code: ""
│ Message: "Provisioning is restricted in this region. Please choose a different region. For exceptions to this rule please open a support request with Issue type of 'Service and subscription limits'. See https://docs.microsoft.com/en-us/azure/sql-database/quota-increase-request for more details."
│ Activity Id: ""
│ ---
│ API Response:
│ ----[start]----
│ {"name":"00000000-0000-0000-ae00-00000000","status":"Failed","startTime":"2025-06-19T03:03:53.143Z","error":{"code":"ProvisioningDisabled","message":"Provisioning is restricted in this region. Please choose a different region. For exceptions to this rule please open a support request with Issue type of 'Service and subscription limits'. See https://docs.microsoft.com/en-us/azure/sql-database/quota-increase-request for more details."}}
│ -----[end]-----
│   with module.module_sql_sqerver.azurerm_mssql_server.child_sqlserver,
│   on ..\modules\10-azurerm_mssql_server\main.tf line 1, in resource "azurerm_mssql_server" "child_sqlserver":
│    1: resource "azurerm_mssql_server" "child_sqlserver" {
````
🔧 In case you face above mentioned error, change the "root_resource_location" to "France Central" or any other available resource location.
````yaml
📝 infra01.auto.tfvars

---------------------------------------------------------------------------------------------------
# ✅ Update this variable with your own Azure region.
root_resource_location        = "France Central"
````

##  Error⚡ Error: External Program Execution Failed
````yaml
│ Error: External Program Execution Failed
│
│   with module.module_sql_sqerver.data.external.get_my_ip,
│   on ..\modules\10-azurerm_mssql_server\data.tf line 16, in data "external" "get_my_ip":
│   16:   program    = ["powershell", "-File", "${path.module}/../../INFRA01/scripts/get_ip.ps1"]
│
│ The data source received an unexpected error while attempting to execute the program.
│
│ Program: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
│ Error Message: File D:\CodeSamples\TerraformCode\AzureCode10-InfrastructureSetup-UserInputForResourceName\INFRA01\scripts\get_ip.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
│     + CategoryInfo          : SecurityError: (:) [], ParentContainsErrorRecordException
│     + FullyQualifiedErrorId : UnauthorizedAccess
│
│ State: exit status 1
````
🔧 In case you face above mentioned error, run the powershell command on your terraform terminal to provide access.

`Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force`
