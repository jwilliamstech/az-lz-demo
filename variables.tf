# ========================== service principal ===========================

variable "sp-subscription-id" {
  description = "Id of the azure subscription where all resources will be created"
  type        = string
}
variable "sp-client-id" {
  description = "Client Id of A Service Principal or Azure Active Directory application registration used for provisioning azure resources"
  type        = string
}
variable "sp-client-secret" {
  description = "Secret of A Service Principal or Azure Active Directory application registration used for provisioning azure resources"
  type        = string
}
variable "sp-tenant-id" {
  description = "Tenant Id of the azure account"
  type        = string
}

# ========================== landing zone hub resource group ============

variable "hub_rg_name" {
  description = "Name of the hub resource group name for the landing zone"
  type        = string
  #default     = "hub-rg"
}

variable "hub_rg_location" {
  description = "Location of the hub for the landing zone"
  type        = string
  #default     = "West US"
}

# ========================== landing zone hub networking ===============

variable "hub_vnet_name" {
  description = "The name of the virtual network"
  type        = string
  #default = "hub-vnet"
}

variable "hub_vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  #default = ["10.63.0.0/20"]
}

variable "hub_vnet_rg_name" {
  description = "The name of the resource group for the virtual network"
  type        = string
  #default = "hub-vnet"
}

variable "hub_vnet_location" {
  description = "The location of the virtual network"
  type        = string
  #default = "hub-vnet"
}

variable "hub_firewall_subnet_name" {
  description = "The name of the firewall subnet within the hub vnet"
  type        = string
  #default = "hub-fw-snet"
}

variable "hub_firewall_subnet_address_prefixes" {
  description = "The address prefix of the firewall subnet within the hub vnet"
  type        = list(string)
  #default = ["10.63.0.0/26"]
}

variable "hub_gateway_subnet_name" {
  description = "The name of the gateway subnet within the hub vnet"
  type        = string
  #default = "hub-gw-snet"
}

variable "hub_gateway_subnet_address_prefixes" {
  description = "The address prefix of the gateway subnet within the hub vnet"
  type        = list(string)
  #default = ["10.63.1.0/26"]
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

# ========================== suffix ======================================

variable "rg_suffix" {
  type        = string
  default     = "rg"
  description = "Suffix of the resource group name that's combined with name of the resource group and environment"
}

# ========================== tags ========================================

variable "default_tags" {
  type = map(any)
  default = {
    "Project"   = "az lz demo"
    "Owner"     = "Joshua Williams"
    "CreatedBy" = "Joshua Williams"
  }
}