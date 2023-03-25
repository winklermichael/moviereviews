variable "env" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}


provider "openstack" {
  alias       = "movie"
  tenant_name = "movie_${var.layer}_${var.env}"
  auth_url    = #{auth_url}#
  region      = "RegionOne"
  use_octavia = true
}


provider "azurerm" {
  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

terraform {
  backend "azurerm" {
    use_azuread_auth = true
  }
}


locals {
  common_tags = {
    environment = var.env
  }
}