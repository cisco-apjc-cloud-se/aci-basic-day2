

### Lookup existing L3 domains ###
data "aci_l3_domain_profile" "l3domain" {
  for_each = var.l3outs

  name = each.value.l3_domain
}


### Create new L3Out(s) in Tenant(s) ###

resource "aci_l3_outside" "l3outs" {
  for_each = var.l3outs

  tenant_dn                     = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  description                   = each.value.description
  name                          = each.value.l3out_name
  relation_l3ext_rs_ectx        = aci_vrf.vrfs[each.value.vrf_name].id  ## Assumes VRF Name also used for map/object key
  relation_l3ext_rs_l3_dom_att  = data.aci_l3_domain_profile.l3domain[each.key].id ## same key used

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
          lp_key              = lp_key
          lprof_name          = lprof.lprof_name
          description         = lprof.description
        }
    ]
  ])
  l3out_lprof_map = {
    for val in local.l3out_lprof_list:
      lower(format("%s-%s", val["l3out_key"], val["lp_key"])) => val
  }

  ## L3Out -> Logical Profiles -> Interface Profiles Map ##
  l3out_lprof_intprof_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for lp_key, lprof in l3out.logical_profiles : [
        for i_key, intprof in lprof.interface_profiles :
          {
            l3out_key       = l3out_key
            lp_key          = lp_key
            i_key           = i_key
            intprof_name    = intprof.intprof_name
            description     = intprof.description
          }
      ]
    ]
  ])
  l3out_lprof_intprof_map = {
    for val in local.l3out_lprof_intprof_list:
      lower(format("%s-%s-%s", val["l3out_key"], val["lp_key"], val["i_key"])) => val
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
            path_key        = path_key
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
      lower(format("%s-%s-%s-%s", val["l3out_key"], val["lp_key"], val["i_key"], val["path_key"])) => val
  }

  ## L3Out -> Logical Profiles -> Nodes Map ##
  l3out_lprof_node_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for lp_key, lprof in l3out.logical_profiles : [
        for n_key, node in lprof.nodes :
          {
            l3out_key       = l3out_key
            lp_key          = lp_key
            n_key           = n_key
            pod             = node.pod
            leaf_node       = node.leaf_node
            loopback_ip     = node.loopback_ip
          }
      ]
    ]
  ])
  l3out_lprof_node_map = {
    for val in local.l3out_lprof_node_list:
      lower(format("%s-%s-%s", val["l3out_key"], val["lp_key"], val["n_key"])) => val
  }

  ## L3Out -> OSPF Map ##
  l3out_ospf_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for o_key, ospf in l3out.ospf_profiles :
        {
          l3out_key           = l3out_key
          o_key               = o_key
          description         = ospf.description
          area_cost           = ospf.area_cost
          area_id             = ospf.area_id
          area_type           = ospf.area_type
        }
    ]
  ])
  l3out_ospf_map = {
    for val in local.l3out_ospf_list:
      lower(format("%s-%s", val["l3out_key"], val["o_key"])) => val
  }

  ## L3Out -> Logical Profiles -> Interface Profiles -> OSPF Config Map ##
  l3out_lprof_intprof_ospf_list = flatten([
    for l3out_key, l3out in var.l3outs : [
      for lp_key, lprof in l3out.logical_profiles : [
        for i_key, intprof in lprof.interface_profiles : [
          for o_key, ospf in intprof.ospf_profiles :
          {
            l3out_key       = l3out_key
            lp_key          = lp_key
            i_key           = i_key
            o_key           = o_key
            tenant_name     = l3out.tenant_name
            description     = ospf.description
            auth_key        = ospf.auth_key
            auth_key_id     = ospf.auth_key_id
            auth_type       = ospf.auth_type
            ospf_policy     = ospf.ospf_policy
          }
        ]
      ]
    ]
  ])
  l3out_lprof_intprof_ospf_map = {
    for val in local.l3out_lprof_intprof_ospf_list:
      lower(format("%s-%s-%s-%s", val["l3out_key"], val["lp_key"], val["i_key"], val["o_key"])) => val
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

### L3Out Configured Nodes ###
resource "aci_logical_node_to_fabric_node" "nodes" {
  for_each = local.l3out_lprof_node_map

  logical_node_profile_dn = aci_logical_node_profile.lprofs[format("%s-%s", each.value.l3out_key, each.value.lp_key)].id
  tdn                     = format("topology/pod-%d/node-%d", each.value.pod, each.value.leaf_node)
  rtr_id                  = each.value.loopback_ip
}


### L3Out OSPF External Policies ###
resource "aci_l3out_ospf_external_policy" "ospf" {
  for_each = local.l3out_ospf_map

  l3_outside_dn  = aci_l3_outside.l3outs[each.value.l3out_key].id
  description    = each.value.description
  area_cost      = each.value.area_cost
  // area_ctrl      = ["redistribute", "summary"]
  area_id        = each.value.area_id
  area_type      = each.value.area_type # "nssa", "regular", "stub"
}

### L3Out OSPF Interface Profile ###

data "aci_ospf_interface_policy" "ospf" {
  for_each = local.l3out_lprof_intprof_ospf_map

  name      = each.value.ospf_policy
  tenant_dn = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
}

resource "aci_l3out_ospf_interface_profile" "ospf" {
  for_each = local.l3out_lprof_intprof_ospf_map

  logical_interface_profile_dn = aci_logical_interface_profile.intprofs[format("%s-%s-%s", each.value.l3out_key, each.value.lp_key, each.value.i_key)].id
  description                  = each.value.description
  auth_key                     = each.value.auth_key
  auth_key_id                  = each.value.auth_key_id
  auth_type                    = each.value.auth_type
  relation_ospf_rs_if_pol      = data.aci_ospf_interface_policy.ospf[each.key].id # Same key
}
