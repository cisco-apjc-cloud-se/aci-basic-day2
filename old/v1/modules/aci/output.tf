output "dpgs" {
  value = local.dpgs
}

locals {
  dpgs = {
    for val in local.ap_epg_list:
      lower(format("%s|%s|%s", val["tenant_name"], val["ap_name"], val["epg_name"])) => val
    }
}


output "test" {
  value = local.bd_l3out_list_map
}
