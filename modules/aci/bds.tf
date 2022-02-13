### Create new Bridge Domain(s) in Tenant VRF(s) ###
resource "aci_bridge_domain" "bds" {
  for_each = var.bds

  tenant_dn                   = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  description                 = each.value.description
  name                        = each.value.bd_name
  arp_flood                   = each.value.arp_flood # "yes", "no"
  relation_fv_rs_ctx          = aci_vrf.vrfs[each.value.vrf_name].id  ## Assumes VRF Name also used for map/object key
  relation_fv_rs_bd_to_out    = lookup(local.bd_l3out_list_map, each.key)
}

### Create flattened object or BDs' Subnets ###
locals {
  ### Bridge Domain -> Subnet Maps ###
  bd_subnet_list = flatten([
    for bd_key, bd in var.bds : [
      for sub_key, subnet in bd.subnets :
        {
          bd_name     = bd.bd_name
          description = subnet.description
          ip          = subnet.ip
          scope       = subnet.scope
          preferred   = subnet.preferred
        }
    ]
  ])
  bd_subnet_map = {
    for val in local.bd_subnet_list:
      lower(format("%s-%s", val["bd_name"], val["ip"])) => val
  }

  ### Bridge Domain -> L3Out Maps ###
  bd_l3out_list_map = {
    for bd_key, bd in var.bds :
      bd_key => [
        for l3out in bd.l3outs:
          aci_l3_outside.l3outs[l3out].id
      ]
  }
  // bd_l3out_list = flatten([
  //   for bd_key, bd in var.bds : [
  //     for l3out in bd.l3outs :
  //
  //   ]
  // ])
  // bd_l3out_map = {
  //   for val in local.bd_l3out_list:
  //     lower(format("%s-%s", val["bd_name"], val["ip"])) => val
  // }

}

### L3 Subnet for Bridge Domain(s) ###
resource "aci_subnet" "bds" {
  for_each = local.bd_subnet_map

  parent_dn           = aci_bridge_domain.bds[each.value.bd_name].id ## Assumes BD Name also used for map/object key
  description         = each.value.description
  ip                  = each.value.ip
  scope               = each.value.scope # ["public"]
  preferred           = each.value.preferred
}
