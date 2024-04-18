terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate01613688RG"
    storage_account_name = "tfstate01613688sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}
