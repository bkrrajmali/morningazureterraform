terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.38.1"
    }

  }
}

provider "azurerm" {
  # Configuration options
  features {
  }
  subscription_id = "dssdsdsdsdsdsdwrwwrwrwrwrwrwrw"
}




resource "azurerm_resource_group" "rg1" {
  name     = "rg-demo"
  location = "eastus"
  tags = {
    project = "ecommerce"
    owner   = "john"
    env     = "dev"
  }
  lifecycle {
    ignore_changes = [ tags ]
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet3"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
   lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_security_group" "sg1" {
  name                = "nsg1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  #depends_on = [ azurerm_subnet.subnet1 ]
}