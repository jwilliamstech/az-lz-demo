# ========================== hub resource group ==========================

resource "azurerm_resource_group" "hub_rg" {
  name     = lower("${var.hub_rg_name}-${local.environment}-${var.rg_suffix}")
  location = var.hub_rg_location
  tags     = merge(local.default_tags, var.default_tags)
}

# ========================== hub networking ==============================

resource "azurerm_virtual_network" "hub_vnet" {
  name                = lower("${var.hub_vnet_name}-${local.environment}-${var.vnet_suffix}")
  address_space       = var.hub_vnet_address_space
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = var.hub_vnet_location
  depends_on          = [azurerm_resource_group.hub_rg]
  tags     = merge(local.default_tags, var.default_tags)
}

resource "azurerm_subnet" "hub_firewall_subnet" {
  name                 = var.hub_firewall_subnet_name
  resource_group_name  = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.hub_firewall_subnet_address_prefixes
  
  
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

resource "azurerm_subnet" "hub_firewall_mgmt_subnet" {
  name                 = var.hub_firewall_mgmt_subnet_name
  resource_group_name  = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.hub_firewall_mgmt_subnet_address_prefixes
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

resource "azurerm_subnet" "hub_gateway_subnet" {
  name                 = var.hub_gateway_subnet_name
  resource_group_name  = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.hub_gateway_subnet_address_prefixes
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

# ========================== firewall  ===================================

resource "azurerm_public_ip" "hub_fw_pip" {
  name                = lower("${var.hub_fw_pip_name}-${local.environment}-${var.pip_suffix}")
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags     = merge(local.default_tags, var.default_tags)
}

resource "azurerm_public_ip" "hub_fw_mgmt_pip" {
  name                = lower("${var.hub_fw_mgmt_pip_name}-${local.environment}-${var.mgmt_pip_suffix}")
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags     = merge(local.default_tags, var.default_tags)
}

resource "azurerm_firewall" "hub_fw" {
  name                = lower("${var.hub_fw_name}-${local.environment}-${var.fw_suffix}")
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  sku_name            = var.hub_fw_sku_name
  sku_tier            = var.hub_fw_sku_tier
  tags     = merge(local.default_tags, var.default_tags)

  ip_configuration {
    name                 = "hub-firewall-ip-config"
    subnet_id            = azurerm_subnet.hub_firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.hub_fw_pip.id
  }

  management_ip_configuration {
    name                 = "hub-firewall-mgmt-ip-config"
    subnet_id            = azurerm_subnet.hub_firewall_mgmt_subnet.id
    public_ip_address_id = azurerm_public_ip.hub_fw_mgmt_pip.id
  }

}

# ========================== log resource group  =========================

resource "azurerm_resource_group" "log_rg" {
  name     = lower("${var.log_rg_name}-${local.environment}-${var.rg_suffix}")
  location = var.log_rg_location
  tags     = merge(local.default_tags, var.default_tags)
}

# ========================== log analytic workspace  =====================

resource "azurerm_log_analytics_workspace" "log" {
  name                = lower("${var.log_name}-${local.environment}-${var.log_suffix}")
  resource_group_name = azurerm_resource_group.log_rg.name
  location            = var.log_location
  sku                 = var.log_sku
  retention_in_days   = var.log_retention_days != "" ? var.log_retention_days : null
  tags                = merge(local.default_tags, var.log_tags)
  
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_resource_group.log_rg,
  ]
}

resource "azurerm_log_analytics_solution" "log_solution" {
  for_each              = var.solution_plan_map
  solution_name         = each.value.solution_name
  resource_group_name   = azurerm_resource_group.log_rg.name
  location              = var.log_location
  workspace_resource_id = azurerm_log_analytics_workspace.log.id
  workspace_name        = azurerm_log_analytics_workspace.log.name
  tags     = merge(local.default_tags, var.default_tags)

  plan {
    product   = each.value.product
    publisher = each.value.publisher
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_log_analytics_workspace.log,
  ]
}

# ========================== key vault  ==================================

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "hub_kv" {
  name                        = lower("${var.kv_name}-${local.environment}-${var.kv_suffix}")
  location                    = azurerm_resource_group.hub_rg.location
  resource_group_name         = azurerm_resource_group.hub_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "Get",
    ]

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_key" "encryption_key" {
  name         = "demo-encryption-key"
  key_vault_id = azurerm_key_vault.hub_kv.id
  key_type     = "RSA"
  key_size     = 2048

  # Operations this key is allowed to perform
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}