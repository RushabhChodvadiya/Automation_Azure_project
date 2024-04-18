resource "azurerm_availability_set" "linux_avs" {
  name                         = "${var.vm_name_prefix}-avs"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_update_domain_count = 5
  platform_fault_domain_count  = 2
  tags                         = var.tags
}

resource "azurerm_public_ip" "linux-ip" {
  name                = "${var.vm_name_prefix}-${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.vm_name_prefix}-${count.index + 1}"
  count               = var.vm_count
  tags                = var.tags
}


resource "azurerm_network_interface" "linux-nic" {
  count               = var.vm_count
  name                = "${var.nic_prefix}-${var.vm_name_prefix}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${var.vm_name_prefix}-ipconfig-${count.index + 1}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux-ip[count.index].id
  }

  tags = var.tags
}


resource "azurerm_linux_virtual_machine" "vm-linux" {
  name                = "${var.vm_name_prefix}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  computer_name       = "${var.vm_name_prefix}-${count.index + 1}"
  count               = var.vm_count

  availability_set_id = azurerm_availability_set.linux_avs.id

  network_interface_ids = [
    azurerm_network_interface.linux-nic[count.index].id
  ]

  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.vmlinux_key_path)
  }

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
  tags = var.tags
}

// Azure Monitorextension [publisher: Microsoft.Azure.Monitor; name: AzureMonitorLinuxAgent; version 1.0]

resource "azurerm_virtual_machine_extension" "vm-linux-monitor" {
  count                = var.vm_count
  name                 = "${var.vm_name_prefix}-${count.index + 1}-monitor"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-linux[count.index].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.6"

  tags = var.tags
}

// Network Watcher extension [publisher:Microsoft.Azure.NetworkWatcher; name: NetworkWatcherAgentLinux; version 1.0]

resource "azurerm_virtual_machine_extension" "vm-linux-nwa" {
  count                = var.vm_count
  name                 = "${var.vm_name_prefix}-${count.index + 1}-nwa"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm-linux[count.index].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"

  tags               = var.tags
  settings           = <<SETTINGS
    {
        "workspaceId": "${var.log_analytics_workspace_id}"
    }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
            {
                "workspaceKey": "${var.log_analytics_workspace_key}"
            }
PROTECTED_SETTINGS
}

