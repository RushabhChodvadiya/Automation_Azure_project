resource "azurerm_availability_set" "windows_avs" {
  name                         = "${var.vm_name_prefix}-avs"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_update_domain_count = 5
  platform_fault_domain_count  = 2
}

resource "azurerm_public_ip" "windows-ip" {
  name                = "${var.vm_name_prefix}-${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.vm_name_prefix}-${count.index + 1}"
  count               = var.vm_count
}


resource "azurerm_network_interface" "windows-nic" {
  count               = var.vm_count
  name                = "${var.nic_prefix}-${var.vm_name_prefix}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${var.vm_name_prefix}-ipconfig-${count.index + 1}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows-ip[count.index].id
  }
}


resource "azurerm_windows_virtual_machine" "vm-windows" {
  name                = "${var.vm_name_prefix}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  computer_name       = "${var.vm_name_prefix}-${count.index + 1}"
  count               = var.vm_count

  availability_set_id = azurerm_availability_set.windows_avs.id

  network_interface_ids = [
    azurerm_network_interface.windows-nic[count.index].id
  ]

  size           = var.vm_size
  admin_username = var.admin_username

  admin_password = var.admin_password

  os_disk {
    name                 = "${var.vm_name_prefix}-osdisk-${count.index + 1}"
    caching              = var.vm_os_disk_caching
    storage_account_type = var.vm_os_disk_storage_account_type
    disk_size_gb         = var.vm_os_disk_disk_size_gb
  }

  source_image_reference {
    publisher = var.os_image["publisher"]
    offer     = var.os_image["offer"]
    sku       = var.os_image["sku"]
    version   = var.os_image["version"]
  }

  boot_diagnostics {
    storage_account_uri = var.vm_boot_diag_primary_blob_endpoint
  }

}


resource "azurerm_virtual_machine_extension" "windows_antimalware" {
  count                = var.vm_count
  virtual_machine_id   = azurerm_windows_virtual_machine.vm-windows[count.index].id
  name                 = "${var.vm_name_prefix}-antimalware-${format("%1d", count.index + 1)}"
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"
}
