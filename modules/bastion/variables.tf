# ========================== hub resource references =====================

variable "hub_rg_name" {
  description = "The name of the resource group"
  type        = string
  #default = "hub-rg"
}

variable "hub_vnet_name" {
  description = "The name of the virtual network"
  type        = string
  #default = "hub-vnet"
}

# ========================== bastion subnet ==============================

variable "bastion_subnet_name" {
  description = "The name of the bastion subnet within the hub vnet"
  type        = string
  #default = "bastion-snet"
}

variable "bastion_subnet_address_prefixes" {
  description = "The address prefix of the bastion subnet within the hub vnet"
  type        = list(string)
  #default = ["10.63.3.0/26"]
}

# ========================== bastion host pip ============================

variable "bastion_pip_name" {
  description = "Specifies the name of the public IP address for the bastion host"
  type        = string
  #default = "bastion-pip"
}

# ========================== bastion host ================================

variable "bastion_name" {
  description = "Specifies the name of the bastion host"
  type        = string
  #default = "bastion-host"
}

variable "bastion_location" {
  description = "Specifies the location of the bastion host"
  type        = string
  #default = "West US"
}

variable "bastion_rg_name" {
  description = "Specifies the name of the resource group for the bastion host"
  type        = string
  #default = "hub-rg"
}

variable "bastion_sku" {
  description = "Specifies the SKU of the bastion host"
  type        = string
  #default        = "basic"
}




