# ========================== azure container registry  ===================

variable "rg_suffix" {
  description = "Suffix of the resource group resource to be combined with the env and resource group name variable"
  type        = string
  default     = "rg"
}