resource "azurerm_resource_group" "az-rg" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_virtual_network" "az-v1" {
  name                = var.vnet_name_1
  resource_group_name = azurerm_resource_group.az-rg.name
  address_space       = ["10.0.1.0/24"]
  location            = azurerm_resource_group.az-rg.location
}

resource "azurerm_virtual_network" "az-v2" {
  name                = var.vnet_name_2
  resource_group_name = azurerm_resource_group.az-rg.name
  address_space       = ["10.0.2.0/24"]
  location            = azurerm_resource_group.az-rg.location
}

resource "azurerm_virtual_network_peering" "az-vnet1to2" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.az-rg.name
  virtual_network_name      = azurerm_virtual_network.az-v1.name
  remote_virtual_network_id = azurerm_virtual_network.az-v2.id
}

resource "azurerm_virtual_network_peering" "az-vnet2to1" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.az-rg.name
  virtual_network_name      = azurerm_virtual_network.az-v2.name
  remote_virtual_network_id = azurerm_virtual_network.az-v1.id
}