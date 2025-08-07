resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg-nprod-ecomm-${random_string.random.id}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
}