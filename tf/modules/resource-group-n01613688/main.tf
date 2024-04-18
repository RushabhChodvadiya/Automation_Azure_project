
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.group_name_prefix}-RG"
  location = var.location
  tags     = var.tags
}
