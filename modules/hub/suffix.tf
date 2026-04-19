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

variable "log_suffix" {
  description = "Suffix of the log analytics workspace resource to be combined with the env and log analytics workspace name variable"
  type        = string
  default     = "log"
}