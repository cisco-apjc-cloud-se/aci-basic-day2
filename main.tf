terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "mel-ciscolabs-com"
    workspaces {
      name = "aci-basic-day2"
    }
  }
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      # version = "~> 0.5.1"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Shared Providers ###

provider "aci" {
  username = var.aci_user
  password = var.aci_password
  url      = var.aci_url
  insecure = true
}

## ACI Tenant Module
module "aci_tenants" {
  for_each = var.tenants
  source = "github.com/cisco-apjc-cloud-se/terraform-aci-tenant-object"

  ### Tenants ###
  tenant   = each.value
}
