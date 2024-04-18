

output "log_workspace_id" {
  value = azurerm_log_analytics_workspace.log_workspace.id
}

output "log_workspace_key" {
  value = azurerm_log_analytics_workspace.log_workspace.primary_shared_key
}

output "recovery_vault" {
  value = azurerm_recovery_services_vault.recovery_vault.name
}

output "storage_account" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}
// 
output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "recovery_vault_name" {
  value = azurerm_recovery_services_vault.recovery_vault.name
}
output "log_workspace" {
  value = azurerm_log_analytics_workspace.log_workspace.name
}