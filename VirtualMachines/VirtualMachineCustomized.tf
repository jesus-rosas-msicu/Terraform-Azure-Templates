provider "azurerm" {
  version = "= 2.0.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
    name = "virtualmachine"
    location = "southcentralus"
}

resource "azurerm_virtual_network" "myvnet" {
    name = "myvnet"
    address_space = "10.0.0.0/23"
    location = "southcentralus"
    resource_group_name = azurerm_resource_group.name
}

resource "azurerm_subnet" "mysubnet" {
    name = "mysubnet"
    resource_group_name = azurerm_resource_group.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    allocation_method = "Dynamic"
    sku = "Basic"
}

resource "azurerm_public_ip" "myip"{
    name = "myip"
    location = "southcentralus"
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Dynamic"
    sku = "Basic"
}


resource "azurerm_network_interface" "mynic" {
    name = "mynic"
    location = "southcentralus"
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name = "ipconfig1"
        subnet_id = azurerm_subnet.mysubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.myip.id
    }
}

resource "azurerm_windows_virtual_machine" "guindos" {
    name = "guindos"
    location = "southcentralus"
    resource_group_name = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.mynic.id]
    size = "Standard_B1s"
    admin_username = "youruser"
    admin_password = "yourpassword"

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2019-DataCenter"
        Version = "latest"
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }


}


