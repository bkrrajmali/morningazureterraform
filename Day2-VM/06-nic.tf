resource "azurerm_network_interface" "example" {
  name                = "nic-nprod-ecomm-${random_string.random.id}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location

  ip_configuration {
    name                          = "pvt-nprod-ecomm-${random_string.random.id}"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my-pip1.id
  }
}
