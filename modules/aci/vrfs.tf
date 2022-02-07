### Create new VRF(s) in Tenant(s) ###
resource "aci_vrf" "vrfs" {
  for_each = var.vrfs

  tenant_dn    = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  name         = each.value.vrf_name
  description  = each.value.description
}
