output "virtual_network_name" {
  value = module.network.network_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "storage_account_name" {
  value = module.common.storage_account_name
}

output "log_workspace_name" {
  value = module.common.log_workspace
}

output "recovery_vault_name" {
  value = module.common.recovery_vault_name
}

output "linux_vm_hostnames" {
  value = join(", ", module.linux_vm.hostnames)
}

output "linux_vm_host_domain_names" {
  value = join(", ", module.linux_vm.domain_name)
}

output "linux_vm_private_ips" {
  value = join(", ", module.linux_vm.priv_ip)
}

output "linux_vm_public_ips" {
  value = join(", ", module.linux_vm.pub_ip)
}

output "windows_vm_hostnames" {
  value = join(", ", module.win_vm.hostnames)
}

output "windows_vm_host_domain_names" {
  value = join(", ", module.win_vm.domain_name)
}

output "load_balancer_name" {
  value = module.lb.lb_name
}

output "databases_name" {
  value = module.db.db_name
}
