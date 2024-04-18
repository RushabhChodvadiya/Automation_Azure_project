# resource "null_resource" "display_hostnames" {
#   count      = var.vm_count
#   depends_on = [azurerm_linux_virtual_machine.vm-linux]
#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "rushabh"
#       private_key = file("${var.vmlinux_priv_key_path}")
#       host        = azurerm_public_ip.linux-ip[count.index].fqdn
#     }
#     inline = [
#       "echo 'The hostname is:' $(hostname)"
#     ]
#   }
# }

resource "null_resource" "ansible" {
  count = var.vm_count
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [ azurerm_linux_virtual_machine.vm-linux ]
  provisioner "local-exec" {
    # command = "ansible-playbook n01613688-playbook.yaml"
    command = "cd ../ansible && env /usr/bin/arch -arm64 ansible-playbook n01613688-playbook.yaml"
  }
}
