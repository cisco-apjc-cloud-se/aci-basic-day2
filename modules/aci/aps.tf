### Create new Application Profiles & End Point Groups ###

### Application Profiles ###
resource "aci_application_profile" "aps" {
  for_each = var.aps

  tenant_dn   = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  name        = each.value.ap_name
  description = each.value.description
}

### Create flattened object for APs' EPGs ###
locals {

  ### App Profile -> EPG Map ###
  ap_epg_list = flatten([
    for ap_key, ap in var.aps : [
      for epg_key, epg in ap.epgs :
        {
          ap_name     = ap.ap_name
          epg_name    = epg.epg_name
          bd_name     = epg.bd_name
          description = epg.description
          selected_esg = epg.selected_esg
        }
      ]
    ])
  ap_epg_map = {
    for val in local.ap_epg_list:
      lower(format("%s-%s", val["ap_name"], val["epg_name"])) => val
    }

  ### App Profile -> EPG -> VMM Map ###
  ap_epg_vmm_list = flatten([
    for ap_key, ap in var.aps : [
      for epg_key, epg in ap.epgs :
        {
          ap_name     = ap.ap_name
          epg_name    = epg.epg_name
          bd_name     = epg.bd_name
          description = epg.description
        }
        if epg.vmm_enabled == true
      ]
    ])
  ap_epg_vmm_map = {
    for val in local.ap_epg_vmm_list:
      lower(format("%s-%s", val["ap_name"], val["epg_name"])) => val
    }

  ### App Profile -> EPG -> Static Paths Map ###
  ap_epg_paths_list = flatten([
    for ap_key, ap in var.aps : [
      for epg_key, epg in ap.epgs : [
        for path_key, path in epg.paths :
          {
            ap_name     = ap.ap_name
            epg_name    = epg.epg_name
            pod         = path.pod
            leaf_node   = path.leaf_node
            port        = path.port
            vlan_id     = path.vlan_id
            mode        = path.mode
          }
          // if length(epg.paths) > 0
        ]
      ]
   ])
  ap_epg_paths_map = {
    for val in local.ap_epg_paths_list:
      lower(format("%s-%s-%d-%d-%s", val["ap_name"], val["epg_name"], val["pod"], val["leaf_node"], val["port"])) => val
    }

  ### App Profile -> ESG Map ###
  ap_esg_list = flatten([
    for ap_key, ap in var.aps : [
      for esg_key, esg in ap.esgs :
        {
          ap_name         = ap.ap_name
          esg_name        = esg.esg_name
          vrf_name        = esg.vrf_name
          description     = esg.description
          preferred_group = esg.preferred_group
          consumed_contracts = esg.consumed_contracts
          provided_contracts = esg.provided_contracts
        }
      ]
    ])
  ap_esg_map = {
    for val in local.ap_esg_list:
      lower(format("%s-%s", val["ap_name"], val["esg_name"])) => val
    }

  # ### App Profile -> EPG -> Selected ESGs ###
  # ap_epg_esg_list = flatten([
  #   for ap_key, ap in var.aps : [
  #     for epg_key, epg in ap.epgs : [
  #       for esg_name in epg.selected_esgs :  ## List not Map
  #         {
  #           ap_name     = ap.ap_name
  #           epg_name    = epg.epg_name
  #           esg_name    = esg_name
  #         }
  #         // if length(epg.selected_esgs) > 0 ## Not needed?
  #       ]
  #     ]
  #  ])
  # ap_epg_esg_map = {
  #   for val in local.ap_epg_esg_list:
  #     lower(format("%s-%s-%s", val["ap_name"], val["epg_name"], val["esg_name"])) => val
  #   }
}

### Create EPG(s) for AP(s) ###
resource "aci_application_epg" "epgs" {
  for_each = local.ap_epg_map

  application_profile_dn    = aci_application_profile.aps[each.value.ap_name].id ## Assumes App Profile Name also used for map/object key
  name                      = each.value.epg_name
  description               = each.value.description
  relation_fv_rs_bd         = aci_bridge_domain.bds[each.value.bd_name].id
}


### Create VMware Distributed Port Groups via ACI VMM Domain ###
resource "aci_epg_to_domain" "dpgs" {
  for_each = local.ap_epg_vmm_map

  application_epg_dn    = aci_application_epg.epgs[format("%s-%s", each.value.ap_name, each.value.epg_name)].id  ## Assumes AP Name & EPG Name also used for map/object key
  tdn                   = data.aci_vmm_domain.vmm.id #"uni/vmmp-VMware/dom-DVS-VMM"
  // vmm_allow_promiscuous = "accept"
  // vmm_forged_transmits  = "accept"
  // vmm_mac_changes       = "accept"
}

### Bind EPG to Static Path(s) ###
resource "aci_epg_to_static_path" "spaths" {
  for_each = local.ap_epg_paths_map

  application_epg_dn  = aci_application_epg.epgs[format("%s-%s", each.value.ap_name, each.value.epg_name)].id  ## Assumes AP Name & EPG Name also used for map/object key
  tdn                 = format("topology/pod-%d/paths-%d/pathep-[%s]", each.value.pod, each.value.leaf_node, each.value.port) #"topology/pod-1/paths-129/pathep-[eth1/3]"
  encap               = format("vlan-%d", each.value.vlan_id)
  mode                = each.value.mode
}


### Create new Endpoint Security Group(s) ###

resource "aci_endpoint_security_group" "esgs" {
  for_each = local.ap_esg_map

  application_profile_dn    = aci_application_profile.aps[each.value.ap_name].id ## Assumes App Profile Name also used for map/object key
  name                      = each.value.esg_name
  description               = each.value.description
  pref_gr_memb              = each.value.preferred_group

  relation_fv_rs_scope      = aci_vrf.vrfs[each.value.vrf_name].id  ## Assumes VRF Name also used for map/object key

  dynamic "relation_fv_rs_cons" {
    for_each = each.value.consumed_contracts
    content {
      prio      = "unspecified" # Requried?
      target_dn = aci_contract.contracts[relation_fv_rs_cons.value.contract_name].id ## Assumes Contract Name also used for map/object key
    }
  }

  dynamic "relation_fv_rs_prov" {
    for_each = each.value.provided_contracts
    content {
      prio      = "unspecified" # Requried?
      match_t   = "AtleastOne"  # Required?
      target_dn = aci_contract.contracts[relation_fv_rs_prov.value.contract_name].id ## Assumes Contract Name also used for map/object key
    }
  }

}

### Map EPGs to ESGs ###
resource "aci_endpoint_security_group_epg_selector" "epgs" {
  for_each = local.ap_epg_map

  endpoint_security_group_dn  = aci_endpoint_security_group.esgs[format("%s-%s", each.value.ap_name, each.value.selected_esg)].id  ## Assumes ESG Name used for map/object key
  match_epg_dn                = aci_application_epg.epgs[format("%s-%s", each.value.ap_name, each.value.epg_name)].id  ## Assumes AP Name & EPG Name also used for map/object key

}
