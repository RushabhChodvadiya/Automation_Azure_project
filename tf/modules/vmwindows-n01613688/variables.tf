variable "vm_count" {
  default = 1
}

variable "vm_name_prefix" {
  default = "win-vm"
}

variable "nic_prefix" {
  default = "win-nic"
}

variable "subnet_id" {}

variable "vm_os_disk_caching" {
  default = "ReadWrite"
}

variable "vm_os_disk_storage_account_type" {
  default = "StandardSSD_LRS"
}

variable "vm_os_disk_disk_size_gb" {
  default = 128
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "rushabh"
}

variable "admin_password" {
  default = "P@ssw0rd1234!"
}

variable "os_image" {
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

variable "vm_boot_diag_primary_blob_endpoint" {}

variable "log_analytics_workspace_id" {}

variable "log_analytics_workspace_key" {}

variable "location" {}
variable "resource_group_name" {}

variable "tags" {}