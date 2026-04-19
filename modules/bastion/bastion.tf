# ========================== bastion subnet ==============================

# Create hub bastion host subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                                          = var.bastion_subnet_name
  resource_group_name                           = var.hub_rg_name
  virtual_network_name                          = var.hub_vnet_name
  address_prefixes                              = var.bastion_subnet_address_prefixes
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = false
  depends_on                                    = []
}

# ========================== bastion host pip ============================

resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion_pip_name
  location            = var.bastion_location
  resource_group_name = var.bastion_rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# ========================== bastion host ================================

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  location            = var.bastion_location
  resource_group_name = var.bastion_rg_name
  sku                 = var.bastion_sku

  ip_configuration {
    name                 = "bastion-configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  depends_on = []
}

