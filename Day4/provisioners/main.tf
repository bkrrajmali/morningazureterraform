terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
    subscription_id = "dssdsdsdsdsdsdwrwwrwrwrwrwrwrw"

  features {}

}

resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = "eastus"
}

resource "azurerm_virtual_network" "myvnet1" {
  name                = "myvnet1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "mysubnet" {
  name                 = "mysubnet1"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.myvnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "mypublic" {
  name                = "mypublicip"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"

}


resource "azurerm_network_interface" "mynic" {
  name                = "mynic"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublic.id

  }
}

resource "azurerm_network_security_group" "mynsg1" {
  name                = "amynsg1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
security_rule {
    name                       = "http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet_network_security_group_association" "mysubnetnsgassociation" {
  subnet_id                 = azurerm_subnet.mysubnet.id
  network_security_group_id = azurerm_network_security_group.mynsg1.id

}




resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B1s"
  admin_username      = "azureadmin"
  network_interface_ids = [
    azurerm_network_interface.mynic.id
  ]

  admin_ssh_key {
    username   = "azureadmin"
    public_key = file("C:\\Users\\Bala\\.ssh\\id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  
}

resource "null_resource" "local" {
  provisioner "local-exec" {
    command = "echo ${azurerm_public_ip.mypublic.ip_address} >> private_ips.txt"
  }
  }

resource "null_resource" "file_copy_remote_run" {
  provisioner "file" {
    source = "install_apache.sh"
    destination = "/tmp/install_apache.sh"
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.mypublic.ip_address
      user        = "azureadmin"
      private_key = file("C:\\Users\\Bala\\.ssh\\id_rsa")
    }
  }




    provisioner "remote-exec" {
        inline = [
        "chmod +x /tmp/install_apache.sh",
        "sudo /tmp/install_apache.sh"
        ]
        connection {
        type        = "ssh"
        host        = azurerm_public_ip.mypublic.ip_address
        user        = "azureadmin"
        private_key = file("C:\\Users\\Bala\\.ssh\\id_rsa")
        }
    }
    depends_on = [azurerm_linux_virtual_machine.example]
}

