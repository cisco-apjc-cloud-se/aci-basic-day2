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
    // vsphere = {
    //   source = "hashicorp/vsphere"
    //   # version = "1.24.2"
    // }
  }
}

### Shared Providers ###

provider "aci" {
  username = var.aci_user
  password = var.aci_password
  url      = var.aci_url
  insecure = true
}

// provider "vsphere" {
//   user           = var.vsphere_user
//   password       = var.vsphere_password
//   vsphere_server = var.vsphere_server
//
//   # If you have a self-signed cert
//   allow_unverified_ssl = true
// }

### Nested Modules ###

## ACI Networking Module
module "aci" {
  source = "./modules/aci"

  ### Tenants ###
  tenants   = var.tenants

  ### VRFs ###
  vrfs      = var.vrfs
  //
  // ### Bridge Domains ###
  // bds       = var.bds
  //
  // ### End Point Groups ###
  // epgs      = var.epgs
  // vmm_name  = var.vmm_name # "DVS-VMM"

}

## VMware Module
# module "esxi" {
#   source = "./modules/esxi"
#   app1-web-net  = module.aci.app1-web-net
#   app1-db-net   = module.aci.app1-db-net
#   app2-web-net  = module.aci.app2-web-net
#   app2-db-net   = module.aci.app2-db-net
#   depends_on = [module.aci]
# }

# output "diskSize" {
#   value = module.esxi.diskSize
# }
