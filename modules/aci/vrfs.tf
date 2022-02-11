### Create new VRF(s) in Tenant(s) ###
resource "aci_vrf" "vrfs" {
  for_each = var.vrfs

  tenant_dn    = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  name         = each.value.vrf_name
  description  = each.value.description
  // pc_enf_pref  = each.value.preferred_group # enforced, unenforced
}

### Preferred Group and vzAny ###
resource "aci_any" "vzany" {
  for_each = var.vrfs

  vrf_dn       = aci_vrf.vrfs[each.key].id  ## Same key used
  // description  = "vzAny Description"
  // annotation   = "tag_any"
  // match_t      = "AtleastOne"
  // name_alias   = "alias_any"
  pref_gr_memb = each.value.preferred_group
}
