resource "azurerm_linux_virtual_machine" "child_virtual_machine" {
  name                            = var.child_virtual_machine_name
  resource_group_name             = var.child_resource_group_name
  location                        = var.child_resource_location
  size                            = "Standard_F2"

  # ⚠️ VM Username is saved in the *.auto.tfvars file. User can change it before 'terraform apply'
  admin_username                  = var.child_virtual_machine_username

  # ❌ Not recommended to use a hardcoded password in production.
  # 🔐 Use a Azure Key Vault in production environments.
  admin_password                  = data.azurerm_key_vault_secret.get_key_vault_secret_vm_password.value  ## ✅ Captured from user input
  
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.get_child_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}



