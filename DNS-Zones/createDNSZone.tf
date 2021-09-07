#Template to create DNS Zones
provider "azurerm" {
  version = "= 2.0.0"
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "tuitbi"
  location = "southcentralus"
}

#Public DNS ZONE
resource "azurerm_dns_zone" "dnszone" {
  name                = "tuitbi.com"
  resource_group_name = azurerm_resource_group.example.name
}


#Private DNS ZONE
resource "azurerm_private_dns_zone" "example-private" {
  name                = "mydomain.com"
  resource_group_name = azurerm_resource_group.example.name
}