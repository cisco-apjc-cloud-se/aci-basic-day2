### Create new L3Out(s) in Tenant(s) ###

resource "aci_l3_outside" "l3outs" {
  for_each = var.l3outs

  tenant_dn      = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  description    = each.value.description
  name           = each.value.l3out_name
}


### Create flattened object of External EPGs' Subnets ###
locals {
  l3out_extepg_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for ext_key, extepg in l3out.extepgs :
        {
          l3out_key           = l3out_key
          extepg_name         = extepg.extepg_name
          description         = extepg.description
          preferred_group     = extepg.preferred_group
          consumed_contracts  = extepg.consumed_contracts
          provided_contracts  = extepg.provided_contracts
        }
    ]
  ])
  l3out_extepg_map = {
    for val in local.l3out_extepg_list:
      lower(format("%s-%s", val["l3out_key"], val["extepg_name"])) => val
  }

  l3out_extepg_subnet_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for e_key, extepg in l3out.extepgs : [
        for s_key, subnet in extepg.subnets :
          {
            l3out_key       = l3out_key
            e_key           = e_key
            description     = subnet.description
            ip              = subnet.ip
            scope           = subnet.scope
            aggregate       = subnet.aggregate
          }
      ]
    ]
  ])
  l3out_extepg_subnet_map = {
    for val in local.l3out_extepg_subnet_list:
      lower(format("%s-%s-%s", val["l3out_key"], val["e_key"], val["ip"])) => val
  }
}

### Create new External EPG(s) under L3Out(s) ###

resource "aci_external_network_instance_profile" "extepgs" {
  for_each = local.l3out_extepg_map

  l3_outside_dn       = aci_l3_outside.l3outs[each.value.l3out_key].id
  description         = each.value.description
  name                = each.value.extepg_name
  pref_gr_memb        = each.value.preferred_group

  relation_fv_rs_cons = [
    for contract_name in each.value.consumed_contracts : aci_contract.contracts[contract_name].id ## Assumes Contract Name also used for map/object key
  ] # aci_contract.tf-rfc1918-to-vlan100.id
  relation_fv_rs_prov = [
    for contract_name in each.value.provided_contracts : aci_contract.contracts[contract_name].id ## Assumes Contract Name also used for map/object key
  ] # aci_contract.tf-vlan100-to-rfc1918.id,

}


resource "aci_l3_ext_subnet" "extsubnets" {
  for_each = local.l3out_extepg_subnet_map

  external_network_instance_profile_dn  = aci_external_network_instance_profile.extepgs[lower(format("%s-%s", each.value.l3out_key, each.value.e_key))].id
  description         = each.value.description
  aggregate           = each.value.aggregate # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
  ip                  = each.value.ip
  scope               = each.value.scope #["import-security"], ["import-security","shared-security"]
}
