#Template to create a blob storage
provider "azurerm" {
  version = "= 2.0.0"
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "production"
  location = "southcentralus"
}    

resource "azurerm_storage_account" "testsa" {
  name                     = "storageaccountname"
  resource_group_name      = "${azurerm_resource_group.test.name}"
  location                 = "southcentralus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}