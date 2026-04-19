# ========================== hub resource group ==========================

variable "hub_rg_name" {
  description = "The name of the resource group"
  type        = string
  #default = "hub-rg"
}

variable "hub_rg_location" {
  description = "The Azure region where hub resource group will be created"
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

# ========================== log resource group  =========================

variable "log_rg_name" {
  description = "The name of the resource group"
  type        = string
  #default = "log-rg"
}

variable "log_rg_location" {
  description = "The Azure region where log analytics workspace resource group will be created"
  type        = string
  #default = "West US"
}

# ========================== log analytic workspace  =====================

variable "log_name" {
  description = "(Required) Specifies the name of the log analytics workspace"
  type        = string
  # default     = "tf-aks"
}

variable "log_location" {
  description = "(Required) Specifies the location of the log analytics workspace"
  type        = string
  #default     = "West US"
}

variable "log_sku" {
  description = "(Optional) Specifies the sku of the log analytics workspace"
  type        = string
  #default     = "PerGB2018"

  validation {
    condition     = contains(["Free", "Standalone", "PerNode", "PerGB2018"], var.log_sku)
    error_message = "The log analytics sku is incorrect."
  }
}

variable "log_retention_days" {
  description = " (Optional) Specifies the workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  type        = number
  #default     = 30
}

variable "log_tags" {
  description = "(Optional) Specifies the tags of the log analytics"
  type        = map(any)
  default     = {}
}

variable "solution_plan_map" {
  type = map(object({
    solution_name = string
    publisher     = string
    product       = string
  }))
  description = "(Required) Specifies solutions to deploy to log analytics workspace"
  default = {
    "ContainerInsights" = {
      solution_name = "ContainerInsights"
      publisher     = "Microsoft"
      product       = "OMSGallery/ContainerInsights"
    }
  }
}

# ========================== tags ========================================

variable "default_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}