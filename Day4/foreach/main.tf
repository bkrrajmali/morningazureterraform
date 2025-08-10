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
for_each = {
  "rg1" = "eastus"
  "rg2" = "westus"
  "rg3" = "centralus"
  
}
  name     = "${each.key}"
  location = each.value
}