resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-nprod-ecomm-${random_string.random.id}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}