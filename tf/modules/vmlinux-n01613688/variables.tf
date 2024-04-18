variable "vm_count" {
  default = 1
}

variable "vm_name_prefix" {
  default = "linux-vm"
}

variable "nic_prefix" {
  default = "linux-nic"
}

variable "subnet_id" {}

variable "vmlinux_key_path" {}

variable "vmlinux_priv_key_path" {}

variable "vm_os_disk_caching" {
  default = "ReadWrite"
}

variable "vm_os_disk_storage_account_type" {
  default = "Premium_LRS"
}

variable "vm_os_disk_disk_size_gb" {
  default = 32
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "rushabh"
}

variable "os_image" {
  default = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_1-gen2"
    version   = "8.1.2020111901"
  }
}

variable "vm_boot_diag_primary_blob_endpoint" {}

variable "log_analytics_workspace_id" {}

variable "log_analytics_workspace_key" {}

variable "location" {}
variable "resource_group_name" {}

variable "tags" {}