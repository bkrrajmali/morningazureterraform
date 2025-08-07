resource "azurerm_public_ip" "my-pip1" {
  name                = "pip-nprod-ecomm-${random_string.random.id}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"

}