# output "dpgs" {
#   value = module.aci.dpgs
#   sensitive = false
# }
#
# output "tenant_map" {
#   value = module.aci_tenants.tenant_map
# }
#
output "vrf_map" {
  value = module.aci_tenants[*].vrf_map
}

output "bd_map" {
  value = module.aci_tenants[*].bd_map
}

output "contract_map" {
  value = module.aci_tenants[*].contract_map
}

output "internal_testing" {
  value = module.aci_tenants[*].internal_testing
}

#
# output "ap_map" {
#   value = module.aci_tenants.ap_map
# }

output "epg_map" {
  value = module.aci_tenants[*].epg_map
}
