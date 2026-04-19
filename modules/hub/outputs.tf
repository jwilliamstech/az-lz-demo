# ========================== hub resource outputs =================

output "hub_rg_name_out" {
  description = "The name of the hub resource group presented as an output value"
  value       = azurerm_resource_group.hub_rg.name
}

output "hub_rg_location_out" {
  description = "The location of the hub resource group presented as an output value"
  value       = azurerm_resource_group.hub_rg.location
}

output "hub_vnet_name_out" {
  description = "The name of the hub virtual network presented as an output value"
  value       = azurerm_resource_group.hub_rg.name
}