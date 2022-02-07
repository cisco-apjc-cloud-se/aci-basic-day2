### Create new Bridge Domain(s) in Tenant VRF(s) ###
resource "aci_bridge_domain" "bds" {
  for_each = var.bds

  tenant_dn                   = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  description                 = each.value.description
  name                        = each.value.bd_name
  relation_fv_rs_ctx          = aci_vrf.vrfs[each.value.vrf_name].id  ## Assumes VRF Name also used for map/object key
}
