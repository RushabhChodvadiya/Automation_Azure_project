// create a log analytics workspace

resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "${var.name_prefix}-log-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  tags                = var.tags
}


resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = "${var.name_prefix}-recovery-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  soft_delete_enabled = true
  tags                = var.tags
}


// standard storage account with LRS redundancy
resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.name_prefix}storage"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}
