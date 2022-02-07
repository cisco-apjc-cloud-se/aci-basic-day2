terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      # version = "~> 0.5.1"
    }
  }
}


## Common Data Sources

### Load VMware VMM Domain
data "aci_vmm_domain" "vmm" {
	provider_profile_dn = "uni/vmmp-VMware"
	name                = var.vmm_name #"DVS-VMM"
}

// ### Load Common Tenant
// data "aci_tenant" "common" {
//   name  = "common"
// }

// ### Load Common L3Out to Lab
// data "aci_l3_outside" "lab" {
//   tenant_dn   = data.aci_tenant.common.id
//   name        = "Lab-9348-Peering"
// }
//
// ### Load Common:Lab VRF
// data "aci_vrf" "tf-common-lab" {
//   tenant_dn   = data.aci_tenant.common.id
//   name        = "Lab"
// }


## Initial Configuration


// ### New Tenant
// resource "aci_tenant" "tf-demo" {
//   name        = "tf-demo"
//   description = "Demo Tenant"
// }

# ### New VRF in Tenant
# resource "aci_vrf" "tf-internal" {
#   tenant_dn    = aci_tenant.tf-demo.id
#   name         = "tf-internal"
#   description  = "Demo VRF - Internal"
# }

// ### Legacy Migration VLAN Bridge Domain
// resource "aci_bridge_domain" "tf-vlan100" {
//   tenant_dn                   = aci_tenant.tf-demo.id
//   description                 = "Migrated VLAN 100"
//   name                        = "tf-vlan100"
//   host_based_routing          = "yes"
//   relation_fv_rs_ctx          = data.aci_vrf.tf-common-lab.id
// }
//
// ### L3 Subnet for Bridge Domain
// resource "aci_subnet" "tf-vlan100" {
//   parent_dn           = aci_bridge_domain.tf-vlan100.id
//   name_alias          = "tf-vlan100"
//   description         = "L3 Subnet for Legacy VLAN 100 BD"
//   ip                  = "10.66.209.81/28"
//   scope               = ["public"]
// }
