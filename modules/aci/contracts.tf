### Create new Contract(s) in Tenant VRF(s) ###

resource "aci_contract" "contracts" {
  for_each = var.contracts

  tenant_dn   = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  description = each.value.description
  name        = each.value.contract_name
  scope       = each.value.scope
}

resource "aci_contract_subject" "subjects" {
  for_each = var.contracts

  contract_dn   = aci_contract.contracts[each.value.contract_name].id  ## Assumes Contract Name also used for map/object key
  description   = "Default Subject"
  name          = "defaultSub"
  relation_vz_rs_subj_filt_att = [
    for filter_name in each.value.filters : aci_filter.filters[filter_name].id ## Assumes Filter Name also used for map/objec key
  ]
}
