# ========================== hub resource group ==========================

resource "azurerm_resource_group" "hub_rg" {
  name     = lower("${var.hub_rg_name}-${local.environment}-${var.rg_suffix}")
  location = var.hub_rg_location
  tags     = merge(local.default_tags, var.default_tags)
}

# ========================== hub networking ==============================

# Create hub virtual network (Management vNet)
resource "azurerm_virtual_network" "hub_vnet" {
  name                = lower("${var.hub_vnet_name}-${local.environment}-${var.vnet_suffix}")
  address_space       = var.hub_vnet_address_space
  resource_group_name = var.hub_vnet_rg_name
  location            = var.hub_vnet_location
  depends_on          = [azurerm_resource_group.hub_rg]
}

# Create hub vnet firewall subnet
resource "azurerm_subnet" "hub_firewall_subnet" {
  name                 = lower("${var.hub_firewall_subnet_name}-${local.environment}-${var.snet_suffix}")
  resource_group_name  = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.hub_firewall_subnet_address_prefixes
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

# Create hub vnet gateway subnet
resource "azurerm_subnet" "hub_gateway_subnet" {
  name                 = lower("${var.hub_gateway_subnet_name}-${local.environment}-${var.snet_suffix}")
  resource_group_name  = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.hub_gateway_subnet_address_prefixes
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
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

# Create log analytics workspace solution
resource "azurerm_log_analytics_solution" "log_solution" {
  for_each              = var.solution_plan_map
  solution_name         = each.value.solution_name
  resource_group_name   = azurerm_resource_group.log_rg.name
  location              = var.log_location
  workspace_resource_id = azurerm_log_analytics_workspace.log.id
  workspace_name        = azurerm_log_analytics_workspace.log.name
  plan {
    product   = each.value.product
    publisher = each.value.publisher
  }
  tags = merge(local.default_tags, var.log_tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_log_analytics_workspace.log,
  ]
}