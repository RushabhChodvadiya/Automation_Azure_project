
locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "rushabh.chodvadiya"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "resource_group" {
  source            = "./modules/resource-group-n01613688"
  location          = var.location
  group_name_prefix = var.humber_id
  tags              = local.tags
}

module "network" {
  source                     = "./modules/network-n01613688"
  location                   = var.location
  resource_group_name        = module.resource_group.resource_group_name
  vnet_name_prefix           = var.humber_id
  subnet_name_prefix         = var.humber_id
  security_group_name_prefix = var.humber_id
  tags                       = local.tags
}

module "common" {
  source              = "./modules/common-n01613688"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  name_prefix         = var.humber_id
  tags                = local.tags
}


module "linux_vm" {
  source                             = "./modules/vmlinux-n01613688"
  location                           = var.location
  resource_group_name                = module.resource_group.resource_group_name
  vm_count                           = 3
  vm_name_prefix                     = "vm-c-n01613688"
  subnet_id                          = module.network.subnet_id
  vm_size                            = "Standard_B1s"
  vm_boot_diag_primary_blob_endpoint = module.common.storage_account_primary_blob_endpoint
  vmlinux_key_path                   = "/Users/rushabhchodvadiya/.ssh/id_rsa.pub"
  vmlinux_priv_key_path              = "/Users/rushabhchodvadiya/.ssh/id_rsa"
  log_analytics_workspace_id         = module.common.log_workspace_id
  log_analytics_workspace_key        = module.common.log_workspace_key
  tags                               = local.tags
}

module "win_vm" {
  source                             = "./modules/vmwindows-n01613688"
  location                           = var.location
  resource_group_name                = module.resource_group.resource_group_name
  vm_count                           = 1
  vm_name_prefix                     = "vm-w-01613688"
  subnet_id                          = module.network.subnet_id
  vm_size                            = "Standard_B1s"
  admin_username                     = "rushabh"
  admin_password                     = "P@ssw0rd1234"
  vm_boot_diag_primary_blob_endpoint = module.common.storage_account_primary_blob_endpoint
  log_analytics_workspace_id         = module.common.log_workspace_id
  log_analytics_workspace_key        = module.common.log_workspace_key
  tags                               = local.tags
}

module "data_disk" {
  source              = "./modules/datadisk-n01613688"
  disk_count          = 4
  disk_size_gb        = 10
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  vm_ids              = concat(module.linux_vm.vm_ids, module.win_vm.vm_ids)
  tags                = local.tags
}

module "lb" {
  source              = "./modules/loadbalancer-n01613688"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  nic_id              = module.linux_vm.nic_ids
  ip_config           = module.linux_vm.ip_config_ids
  tags                = local.tags
}

module "db" {
  source              = "./modules/database-n01613688"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  tags                = local.tags
}
