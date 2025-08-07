resource "azurerm_subnet" "subnet1" {
  name                 = "subnet-nprod-ecomm-${random_string.random.id}"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
}
