output "hostnames" {
  value = azurerm_windows_virtual_machine.vm-windows[*].computer_name
}

output "domain_name" {
  value = azurerm_public_ip.windows-ip[*].domain_name_label
}

output "priv_ip" {
  value = azurerm_network_interface.windows-nic[*].private_ip_address
}

output "pub_ip" {
  value = azurerm_public_ip.windows-ip[*].ip_address
}

output "vm_ids" {
  value = azurerm_windows_virtual_machine.vm-windows[*].id
}