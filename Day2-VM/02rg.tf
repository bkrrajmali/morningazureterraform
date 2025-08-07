resource "azurerm_resource_group" "rg1" {
  name     = "rg-nprod-ecomm-${random_string.random.id}"
  location = "eastus"
  tags = {
    project = "ecommerce"
    owner   = "john"
    env     = "dev"
    appref  = "${random_string.random.id}"
  }
}

