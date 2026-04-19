# ========================== hub resource group ==========================

variable "hub_rg_name" {
  description = "The name of the resource group"
  type        = string
  #default = "hub-rg"
}

variable "hub_rg_location" {
  description = "The Azure region where resources will be created"
  type        = string
  #default = "West US"
}

# ========================== hub networking ==============================

variable "hub_vnet_name" {
  description = "The name of the virtual network"
  type        = string
  #default = "hub-vnet"
}

variable "hub_vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  #default = ["10.63.0.0/16"]
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

# ========================== tags ========================================

variable "default_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}