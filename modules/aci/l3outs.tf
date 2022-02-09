### Create new L3Out(s) in Tenant(s) ###

resource "aci_l3_outside" "l3outs" {
  for_each = var.l3outs

  tenant_dn      = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  description    = each.value.description
  name           = each.value.l3out_name
}


### Create flattened object of External EPGs' Subnets ###
locals {
  ## L3Out -> Ext EPG Map ##
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

  ## L3Out -> Ext EPG -> Subnet Map ##
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

  ## L3Out -> Logical Profiles Map ##
  l3out_lprof_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for lp_key, lprof in l3out.logical_profiles :
        {
          l3out_key           = l3out_key
          lprof_name          = lprof.lprof_name
          description         = lprof.description
        }
    ]
  ])
  l3out_lprof_map = {
    for val in local.l3out_lprof_list:
      lower(format("%s-%s", val["l3out_key"], val["lprof_name"])) => val
  }

  ## L3Out -> Logical Profiles -> Interface Profiles Map ##
  l3out_lprof_intprof_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for lp_key, lprof in l3out.logical_profiles : [
        for i_key, intprof in lprof.interface_profiles :
          {
            l3out_key       = l3out_key
            lp_key          = lp_key
            intprof_name    = intprof.intprof_name
            description     = intprof.description
          }
      ]
    ]
  ])
  l3out_lprof_intprof_map = {
    for val in local.l3out_lprof_intprof_list:
      lower(format("%s-%s-%s", val["l3out_key"], val["lp_key"], val["intprof_name"])) => val
  }

  ## L3Out -> Logical Profiles -> Interface Profiles -> Paths Map ##
  l3out_lprof_intprof_path_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for lp_key, lprof in l3out.logical_profiles : [
        for i_key, intprof in lprof.interface_profiles : [
          for path_key, path in intprof.paths :
          {
            l3out_key       = l3out_key
            lp_key          = lp_key
            i_key           = i_key
            description     = path.description
            type            = path.type # if_inst_t  "ext-svi", "l3-port", "sub-interface", "unspecified"
            ip              = path.ip # addr
            encap           = path.type == "l3-port" ? "unknown" : format("vlan-%d", path.vlan_id)  # set to "unknown" for l3-port types
            // encap_scope     = path.vlan_scope # "ctx", "local"
            pod             = path.pod
            leaf_node       = path.leaf_node
            port            = path.port


          }
        ]
      ]
    ]
  ])
  l3out_lprof_intprof_path_map = {
    for val in local.l3out_lprof_intprof_path_list:
      lower(format("%s-%s-%s-%s", val["l3out_key"], val["lp_key"], val["i_key"], val["ip"])) => val
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



### L3Out Logical Profiles ###
resource "aci_logical_node_profile" "lprofs" {
  for_each = local.l3out_lprof_map

  l3_outside_dn = aci_l3_outside.l3outs[each.value.l3out_key].id
  description   = each.value.description
  name          = each.value.lprof_name
}

### L3Out Logical Interface Profiles ###
resource "aci_logical_interface_profile" "intprofs" {
  for_each = local.l3out_lprof_intprof_map

  logical_node_profile_dn = aci_logical_node_profile.lprofs[format("%s-%s", each.value.l3out_key, each.value.lp_key)].id
  description             = each.value.description
  name                    = each.value.intprof_name
}

### L3Out Interface Path Attachments ###
resource "aci_l3out_path_attachment" "paths" {
  for_each = local.l3out_lprof_intprof_path_map

  logical_interface_profile_dn  = aci_logical_interface_profile.intprofs[format("%s-%s-%s", each.value.l3out_key, each.value.lp_key, each.value.i_key)].id
  target_dn                     = format("topology/pod-%d/paths-%d/pathep-[%s]", each.value.pod, each.value.leaf_node, each.value.port)
  if_inst_t                     = each.value.type
  description                   = each.value.description
  addr                          = each.value.ip
  encap                         = each.value.encap
  // encap_scope = "ctx"
}
