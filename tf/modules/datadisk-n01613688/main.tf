resource "azurerm_managed_disk" "disk" {
  count                = var.disk_count
  name                 = "datadisk-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  disk_size_gb         = var.disk_size_gb
  create_option        = "Empty"
  storage_account_type = "StandardSSD_LRS"
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attch" {
  count              = var.disk_count
  managed_disk_id    = azurerm_managed_disk.disk[count.index].id
  virtual_machine_id = var.vm_ids[count.index]
  lun                = count.index
  caching            = "ReadWrite"
}