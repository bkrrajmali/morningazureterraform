terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.38.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
  }
  subscription_id = "SAFFASFSAGFSAGSDGSASA"
}


resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false

}

