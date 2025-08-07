terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.38.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
  }
 subscription_id = "cfsafsafggsaga6"
}


resource "random_string" "random" {
  length           = 6
  special          = false
  upper             = false

}

resource "azurerm_resource_group" "rg1" {
  name = "rg-nprod-ecomm-${random_string.random.id}"
  location = "eastus"
  tags = {
    project = "ecommerce"
    owner   = "john"
    env     = "dev"
    appref = "${random_string.random.id}"
  }
}
