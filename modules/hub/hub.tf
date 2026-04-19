# ========================== hub resource group ==========================

resource "azurerm_resource_group" "hub_rg" {
  name     = var.hub_rg_name
  location = var.hub_rg_location
  tags     = merge(local.default_tags, var.default_tags)
}

# ========================== hub networking ==============================

# Create hub virtual network (Management vNet)
resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  address_space       = var.hub_vnet_address_space
  resource_group_name = var.hub_vnet_rg_name
  location            = var.hub_vnet_location
  depends_on          = [azurerm_resource_group.hub_rg]
}

# Create hub vnet firewall subnet
resource "azurerm_subnet" "hub_firewall_subnet" {
  name                 = var.hub_firewall_subnet_name
  resource_group_name  = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.hub_firewall_subnet_address_prefixes
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

# Create hub vnet gateway subnet
resource "azurerm_subnet" "hub_gateway_subnet" {
  name                 = var.hub_gateway_subnet_name
  resource_group_name  = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.hub_gateway_subnet_address_prefixes
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}


