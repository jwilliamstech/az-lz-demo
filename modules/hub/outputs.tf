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
  value       = azurerm_virtual_network.hub_vnet.name
}

output "kv_id_out" {
  description = "The name of the hub virtual network presented as an output value"
  value       = azurerm_key_vault.hub_kv.id
}

output "kv_encryption_key_id" {
  description = "The id of the key vault encryption key presented as an output value"
  value       = azurerm_key_vault_key.encryption_key.id
}