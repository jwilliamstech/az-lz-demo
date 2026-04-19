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