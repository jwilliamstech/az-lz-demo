# ========================== landing zone hub ============================

# Acts as the centralized management hub for the subscription
# Contains resources deemed necessary for well architected deployments but is not all inclusive of hub resources
module "hub" {
  source                               = "./modules/hub"
  hub_rg_name                          = var.hub_rg_name
  hub_rg_location                      = var.hub_rg_location
  hub_vnet_name                        = var.hub_vnet_name
  hub_vnet_address_space               = var.hub_vnet_address_space
  hub_vnet_rg_name                     = var.hub_rg_name
  hub_vnet_location                    = var.hub_rg_location
  hub_firewall_subnet_name             = var.hub_firewall_subnet_name
  hub_firewall_subnet_address_prefixes = var.hub_firewall_subnet_address_prefixes
  hub_gateway_subnet_name              = var.hub_gateway_subnet_name
  hub_gateway_subnet_address_prefixes  = var.hub_gateway_subnet_address_prefixes
  log_rg_name                          = var.log_rg_name
  log_rg_location                      = var.log_rg_location
  log_name                             = var.log_name
  log_location                         = var.log_location
  log_sku                              = var.log_sku
  log_retention_days                   = var.log_retention_days

}

# ========================== bastion =====================================

# Bastion should be in hub (management) vnet to support well architected framework hub-spoke topology
module "bastion" {
  source                          = "./modules/bastion"
  hub_rg_name                     = module.hub.hub_rg_name_out
  hub_vnet_name                   = module.hub.hub_vnet_name_out
  bastion_subnet_name             = var.bastion_subnet_name
  bastion_subnet_address_prefixes = var.bastion_subnet_address_prefixes
  bastion_pip_name                = var.bastion_pip_name
  bastion_name                    = var.bastion_name
  bastion_location                = module.hub.hub_rg_location_out
  bastion_rg_name                 = module.hub.hub_rg_name_out
  bastion_sku                     = var.bastion_sku
}