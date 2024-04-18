resource "azurerm_postgresql_server" "db" {
  name                         = "lab-db-rushabh"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku_name                     = "B_Gen5_1"
  administrator_login          = "azureuser"
  administrator_login_password = "Password1234!"
  version                      = "10"
  ssl_enforcement_enabled      = true
  tags                         = var.tags
}
