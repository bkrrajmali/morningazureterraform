terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "backend"
    storage_account_name = "ncplterraformbackend"
    container_name = "terraform"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "efaaaaaaaaaaaaaaaa"
}

#1.RG
#2.vnet
#3.subnet

variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "address_space" {}
variable "subnet_name" {}
variable "address_prefixes" {}

resource "azurerm_resource_group" "demorg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "demovnet" {
  name = var.vnet_name
  resource_group_name = azurerm_resource_group.demorg.name
  location = azurerm_resource_group.demorg.location
  address_space = var.address_space
}

resource "azurerm_subnet" "demosubnet" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.demorg.name
  virtual_network_name = azurerm_virtual_network.demovnet.name
  address_prefixes = var.address_prefixes
}

