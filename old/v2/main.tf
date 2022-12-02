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

## ACI Networking Module
module "aci" {
  # source = "./modules/aci"
  source = "github.com/cisco-apjc-cloud-se/terraform-aci-day2"

  ### Tenants ###
  tenants   = var.tenants

  ### VRFs ###
  vrfs      = var.vrfs

  ### Bridge Domains ###
  bds       = var.bds

  ### Application Profiles & End Point Groups ###
  aps       = var.aps
  vmm_name  = var.vmm_name # "DVS-VMM"
  phys_name = var.phys_name # "LAB-N9348"

  ### L3Outs & External EPGs ###
  l3outs    = var.l3outs

  ### Contract & Filters ###
  filters   = var.filters
  contracts = var.contracts

}
