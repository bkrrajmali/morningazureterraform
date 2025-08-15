output "resource_group" { value = module.rg.name }
output "vnet_name" { value = module.net.vnet_name }
output "subnet_id" { value = module.net.subnet_id }
output "nic_id" { value = module.nic.nic_id }
output "vm_private_ip" { value = module.vm.private_ip }
output "vm_public_ip" { value = module.pip.public_ip }
output "vm_id" { value = module.vm.id }
