output "root_output_resource_group_name" {
  description = "Resource Group Name: "
  value       = "Resource Group Name: ${module.module_resource_group.child_output_resource_group_name}"
}

output "root_output_resource_group_name_key_vault" {
  description = "Key Vault Resource Group Name: "
  value       = "Key Vault Resource Group Name: ${module.module_resource_group_key_vault.child_output_resource_group_name}"
}

output "root_output_key_vault_name" {
  description = "Key Vault Name: "
  value       = "Key Vault Name: ${module.module_key_vault.child_output_key_vault_name}"
}

output "root_output_public_ip" {
  description = "VM Public IP: "
  value       = "VM Public IP: ${module.module_public_ip.child_output_public_IP}"
}

output "root_output_virtual_machine" {
  description = "Virtual Machine Name: "
  value       = "Virtual Machine Name: ${module.module_virtual_machine.child_output_virtual_machine_name}"
}

output "root_output_virtual_machine_username" {
  description = "Virtual Machine: Username: "
  value       = "SQL Server: Username: ${module.module_virtual_machine.child_output_virtual_machine_username}"
}

output "root_output_sql_server_username" {
  description = "Virtual Machine: Username: "
  value       = "SQL Server: Username: ${module.module_sql_sqerver.child_output_sql_server_username}"
}