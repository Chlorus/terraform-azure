resource "azurerm_virtual_machine" "srcds" {
  name = "srcds-dev-01"
  location = "${azurerm_resource_group.gaming.location}"
  resource_group_name = "${azurerm_resource_group.gaming.name}"
  network_interface_ids = ["${azurerm_network_interface.srcds.id}"]
  vm_size = "Standard_B2s"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2016-Datacenter"
    version = "latest"
  }
  storage_os_disk {
    name = "osdisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "srcds-dev-01"
    admin_username = "${var.adminuser}"
    admin_password = "${var.adminpassword}"
  }

  os_profile_windows_config {
    provision_vm_agent = true
    enable_automatic_upgrades = true
    timezone = "Mountain Standard Time"

  }

  tags {
    environment = "Dev"
  }


}