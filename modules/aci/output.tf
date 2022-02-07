// locals {
//   app1-web-net  = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-migrated-vlans.name,aci_application_epg.tf-vlan100.name])
//   app1-db-net   = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-migrated-vlans.name,aci_application_epg.tf-vlan100.name])
//   app2-web-net  = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-migrated-vlans.name,aci_application_epg.tf-vlan100.name])
//   app2-db-net   = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-migrated-vlans.name,aci_application_epg.tf-vlan100.name])
// }
//
// output "app1-web-net" {
//   value = local.app1-web-net
// }
//
// output "app1-db-net" {
//   value = local.app1-db-net
// }
//
// output "app2-web-net" {
//   value = local.app2-web-net
// }
//
// output "app2-db-net" {
//   value = local.app2-db-net
// }
