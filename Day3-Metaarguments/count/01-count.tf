terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.38.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
  }
 subscription_id = "SAFFASFSAGFSAGSDGSASA"
}


resource "azurerm_resource_group" "rg1" {
  count =3
  name = "rg${count.index}"
  location = "eastus"
}


