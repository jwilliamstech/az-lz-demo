variable "rg_suffix" {
  description = "Suffix of the resource group resource to be combined with the env and resource group name variable"
  type        = string
  default     = "rg"
}

variable "vnet_suffix" {
  description = "Suffix of the vnet resource to be combined with the env and vnet name variable"
  type        = string
  default     = "vnet"
}

variable "snet_suffix" {
  description = "Suffix of the subnet resource to be combined with the env and subnet name variable"
  type        = string
  default     = "snet"
}

variable "fw_suffix" {
  description = "Suffix of the azure firewall resource to be combined with the env and firewall name variable"
  type        = string
  default     = "fw"
}

variable "pip_suffix" {
  description = "Suffix of the public IP resource to be combined with the env and pip name variable"
  type        = string
  default     = "pip"
}

variable "mgmt_pip_suffix" {
  description = "Suffix of the public IP resource to be combined with the env and pip name variable"
  type        = string
  default     = "mgmt-pip"
}

variable "log_suffix" {
  description = "Suffix of the log analytics workspace resource to be combined with the env and log analytics workspace name variable"
  type        = string
  default     = "log"
}

variable "kv_suffix" {
  description = "Suffix of the key vault resource to be combined with the env and key vault workspace name variable"
  type        = string
  default     = "kv"
}