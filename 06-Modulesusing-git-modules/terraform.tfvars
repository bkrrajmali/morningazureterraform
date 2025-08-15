project_name     = "demo-vm"
location         = "eastus"
address_space    = ["10.10.0.0/16"]
subnet_prefix    = "10.10.1.0/24"
admin_username   = "azureadmin"
admin_password   = "Welcome@123456" # Use a strong password meeting Azure policy
vm_size          = "Standard_B1s"
create_public_ip = true
allow_ssh_cidr   = "0.0.0.0/0" # tighten for prod
tags = {
  project = "demo-vm"
  env     = "dev"
  owner   = "iac"
}
