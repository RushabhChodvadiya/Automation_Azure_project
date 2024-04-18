output "hostnames" {
  value = azurerm_linux_virtual_machine.vm-linux[*].computer_name
}

output "domain_name" {
  value = azurerm_public_ip.linux-ip[*].domain_name_label
}

output "priv_ip" {
  value = azurerm_network_interface.linux-nic[*].private_ip_address
}

output "pub_ip" {
  value = azurerm_public_ip.linux-ip[*].ip_address
}

output "vm_ids" {
  value = azurerm_linux_virtual_machine.vm-linux[*].id
}

output "nic_ids" {
  value = azurerm_network_interface.linux-nic[*].id
}

output "ip_config_ids" {
  value = azurerm_network_interface.linux-nic[*].ip_configuration[0].name
}
