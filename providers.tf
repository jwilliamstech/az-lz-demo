terraform {
  required_version = ">= 1.14.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.8.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azuread" {
  tenant_id = var.sp-tenant-id
}

provider "azurerm" {
  features {}
  subscription_id = var.sp-subscription-id
  client_id       = var.sp-client-id
  client_secret   = var.sp-client-secret
  tenant_id       = var.sp-tenant-id
}

provider "azapi" {
}

provider "random" {}