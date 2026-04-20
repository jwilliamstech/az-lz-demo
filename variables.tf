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

variable "hub_location" {
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
  #default = ["10.63.0.0/20"] # Address space to contain all hub (management) resources (65,536 possible IPs)
}

/*variable "hub_vnet_rg_name" {
  description = "The name of the resource group for the virtual network"
  type        = string
  #default = "hub-vnet"
}*/

variable "hub_vnet_location" {
  description = "The location of the virtual network"
  type        = string
  #default = "hub-vnet"
}

variable "hub_firewall_subnet_name" {
  description = "The name of the firewall subnet within the hub vnet"
  type        = string
  #default = "AzureFirewallSubnet" # Azure requires the exact value of "AzureFirewallSubnet" for a firewall subnet
}

variable "hub_firewall_subnet_address_prefixes" {
  description = "The address prefix of the firewall subnet within the hub vnet"
  type        = list(string)
  #default = ["10.63.0.0/16"] # Address space to contain all hub (management) resources (65,536 possible IPs)
}

variable "hub_firewall_mgmt_subnet_name" {
  description = "The name of the firewall subnet within the hub vnet"
  type        = string
  default     = "AzureFirewallSubnet" # Azure requires the exact value of "AzureFirewallSubnet" for a firewall subnet
}

variable "hub_firewall_mgmt_subnet_address_prefixes" {
  description = "The address prefix of the firewall subnet within the hub vnet"
  type        = list(string)
  #default = ["10.63.0.128/26"] # Azure requires /26 or larger address space for a firewall subnet (64 possible IPs)
}

variable "hub_gateway_subnet_name" {
  description = "The name of the gateway subnet within the hub vnet"
  type        = string
  #default = "GatewaySubnet" # Azure requires the exact value of "GatewaySubnet" for a vnet gateway subnet
}

variable "hub_gateway_subnet_address_prefixes" {
  description = "The address prefix of the gateway subnet within the hub vnet"
  type        = list(string)
  #default = ["10.63.1.0/27"] # Azure requires /27 or larger address space for gateway subnets (32 possible IPs)
}

# ========================== firewall  ===================================

variable "hub_fw_pip_name" {
  description = "The name of the hub firewall public ip"
  type        = string
  #default = "az-lz-demo-fw"
}

variable "hub_fw_mgmt_pip_name" {
  description = "The name of the hub firewall public ip"
  type        = string
  #default = "az-lz-demo-fw"
}

variable "hub_fw_name" {
  description = "The name of the hub firewall"
  type        = string
  #default = "az-lz-demo-hub"
}

variable "hub_fw_location" {
  description = "The location of the hub firewall"
  type        = string
  #default = "West US"
}

variable "hub_fw_sku_name" {
  description = "Specifies the sku of the hub firewall"
  type        = string
  #default     = "AZFW_VNet"

  validation {
    condition     = contains(["AZFW_Hub", "AZFW_VNet"], var.hub_fw_sku_name)
    error_message = "The firewall sku name is incorrect."
  }
}

variable "hub_fw_sku_tier" {
  description = "Specifies the sku tier of the hub firewall"
  type        = string
  #default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.hub_fw_sku_tier)
    error_message = "The firewall sku tier is incorrect."
  }
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

# ========================== key vault  ==================================

variable "kv_name" {
  description = "(Required) Specifies the name of the keyvault"
  type        = string
  #default     = "hub-kv"
}

# ========================== bastion subnet ==============================

variable "bastion_subnet_name" {
  description = "The name of the bastion subnet within the hub vnet"
  type        = string
  #default = "AzureBastionSubnet" # Azure requires the exact value of "AzureBastionSubnet" for a bastion subnet
}

variable "bastion_subnet_address_prefixes" {
  description = "The address prefix of the bastion subnet within the hub vnet"
  type        = list(string)
  #default = ["10.63.2.0/26"] # Azure requires /26 or larger address space for a bastion subnet (64 possible IPs)
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

/*variable "bastion_location" {
  description = "Specifies the location of the bastion host"
  type        = string
  #default = "West US"
}

variable "bastion_rg_name" {
  description = "Specifies the name of the resource group for the bastion host"
  type        = string
  #default = "hub-rg"
}*/

variable "bastion_sku" {
  description = "Specifies the SKU of the bastion host"
  type        = string
  #default        = "basic"

  validation {
    condition     = contains(["Developer", "Basic", "Standard", "Premium"], var.bastion_sku)
    error_message = "The bastion host sku is incorrect."
  }
}

# ========================== azure container registry  ===================

variable "acr_rg_name" {
  description = "Name of the acr resource group name"
  type        = string
  #default     = "acr-rg"
}

variable "acr_rg_location" {
  description = "Location of the acr resource group name"
  type        = string
  #default     = "West US
}

variable "acr_sku" {
  description = "(Optional) Specifies the sku of the log analytics workspace"
  type        = string
  #default     = "PerGB2018"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "The azure container registy sku is incorrect."
  }
}

# Encryption requires premium acr sku. Commented out for demo
/*variable "kv_key_id" {
  description = "ID of the key vault key"
  type        = string
  sensitive   = true
  #default     = "kv_key_id"
}*/

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
    "Project"    = "az-lz-demo"
    "Owner"      = "jwilliamstech"
    "Department" = "Demo"
    "CreatedBy"  = "Joshua Williams"
  }
}