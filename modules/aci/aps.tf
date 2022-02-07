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
   ap_epg_list = flatten([
    for ap_key, ap in var.aps : [
      for epg_key, epg in ap.epgs :
        {
          ap_name     = ap.ap_name
          epg_name    = epg.epg_name
          bd_name     = epg.bd_name
          description = epg.description
        }
    ]
  ])
  ap_epg_map = {
    for val in local.ap_epg_list:
      lower(format("%s-%s", val["ap_name"], val["epg_name"])) => val
  }
}

### Create EPG(s) for AP(s) ###
resource "aci_application_epg" "epgs" {
  for_each = local.ap_epg_map

  application_profile_dn    = aci_application_profile.aps[each.value.ap_name].id ## Assumes App Profile Name also used for map/object key
  name                      = each.value.epg_name
  description               = each.value.description
  relation_fv_rs_bd         = aci_bridge_domain.bds[each.value.bd_name].id
}


### Extend to VMM Domain
resource "aci_epg_to_domain" "dpgs" {
  for_each = local.ap_epg_map

  application_epg_dn    = aci_application_epg.epgs[format("%s-%s", each.value.ap_name, each.value.epg_name)].id  ## Assumes AP Name & EPG Name also used for map/object key
  tdn                   = data.aci_vmm_domain.vmm.id #"uni/vmmp-VMware/dom-DVS-VMM"
  // vmm_allow_promiscuous = "accept"
  // vmm_forged_transmits  = "accept"
  // vmm_mac_changes       = "accept"
}
