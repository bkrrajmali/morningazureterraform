terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "dssdsdsdsdsdsdwrwwrwrwrwrwrwrw"
}

resource "azurerm_resource_group" "demo-rg" {
  count    = 3
  name     = "rg-${count.index + 1}"
  location = "canadacentral"
}

resource "azurerm_virtual_network" "vnet1" {
  count               = 3
  name                = "vnet-${count.index + 1}"
  resource_group_name = azurerm_resource_group.demo-rg[count.index].name
  location            = azurerm_resource_group.demo-rg[count.index].location
  address_space       = ["10.${count.index}.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  count = 9
  name = "subnet-${floor(count.index / 3) + 1}-${count.index % 3 + 1}"
  resource_group_name  = azurerm_resource_group.demo-rg[floor(count.index / 3)].name
  virtual_network_name = azurerm_virtual_network.vnet1[floor(count.index / 3)].name
  address_prefixes     = ["10.${floor(count.index / 3)}.${count.index % 3 + 1}.0/24"]
}
