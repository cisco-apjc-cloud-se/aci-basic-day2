### Create new Filter(s) in Tenant VRF(s) ###

## New Filters

resource "aci_filter" "filters" {
  for_each = var.filters

  tenant_dn   = aci_tenant.tenants[each.value.tenant_name].id  ## Assumes Tenant Name also used for map/object key
  description = each.value.description
  name        = each.value.filter_name
}

### Create flattened object or filters' entries ###
locals {
   filter_entry_list = flatten([
    for f_key, filter in var.filters : [
      for e_key, entry in filter.entries :
        {
          f_key         = f_key
          description   = entry.description
          name          = entry.name
          ether_t       = entry.ether_t
          d_from_port   = entry.d_from_port
          d_to_port     = entry.d_to_port
          prot          = entry.prot
          s_from_port   = entry.s_from_port
          s_to_port     = entry.s_to_port
        }
    ]
  ])
  filter_entry_map = {
    for val in local.filter_entry_list:
      lower(format("%s-%s", val["f-key"], val["name"])) => val
  }
}

resource "aci_filter_entry" "entries" {
  for_each = local.filter_entry_map

  filter_dn     = aci_filter.filters[each.value.f_key].id
  description   = each.value.description
  name          = each.value.name
  ether_t       = each.value.ether_t
  d_from_port   = each.value.d_from_port
  d_to_port     = each.value.d_to_port
  prot          = each.value.prot
  s_from_port   = each.value.s_from_port
  s_to_port     = each.value.s_to_port
}
