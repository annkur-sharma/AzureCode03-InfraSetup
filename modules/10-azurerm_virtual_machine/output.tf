output "child_output_virtual_machine_name" {
  description = "Virtual Machine Name: "
  value = azurerm_linux_virtual_machine.child_virtual_machine.name
}

output "child_output_virtual_machine_username" {
  description = "Virtual Machine Name: Username: "
  value = azurerm_linux_virtual_machine.child_virtual_machine.admin_username
}