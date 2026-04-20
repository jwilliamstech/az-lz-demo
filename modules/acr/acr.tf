# ========================== azure container registry  ===================

resource "azurerm_resource_group" "acr_rg" {
  name     = lower("${var.acr_rg_name}-${local.environment}-${var.rg_suffix}")
  location = var.acr_rg_location
}

resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.acr_rg.name
  location            = azurerm_resource_group.acr_rg.location
  sku                 = var.acr_sku

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_identity.id
    ]
  }

  # Encryption requires premium acr sku. Commented out for demo
  /*encryption {
    key_vault_key_id   = var.kv_key_id
    identity_client_id = azurerm_user_assigned_identity.acr_identity.client_id
  }*/

}

resource "azurerm_user_assigned_identity" "acr_identity" {
  resource_group_name = azurerm_resource_group.acr_rg.name
  location            = azurerm_resource_group.acr_rg.location
  name                = "demo-acr-identity"
  depends_on = [
    azurerm_resource_group.acr_rg,
  ]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
