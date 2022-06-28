# output "dpgs" {
#   value = module.aci.dpgs
#   sensitive = false
# }

output "tenant_map" {
  value = module.aci_tenants.tenant_map
}

output "vrf_map" {
  value = module.aci_tenants.vrf_map
}
