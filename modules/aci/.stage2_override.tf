# ### Bind ExEPG to Contracts
# resource "aci_external_network_instance_profile" "exepg-rfc1918" {
#     relation_fv_rs_cons = [
#       ## Stage 2
#       aci_contract.tf-rfc1918-to-app1.id,
#       aci_contract.tf-rfc1918-to-app2.id,
#     ]
#     relation_fv_rs_prov = [
#       ## Stage 2
#       aci_contract.tf-app1-to-rfc1918.id,
#       aci_contract.tf-app2-to-rfc1918.id,
#     ]
# }
#
# resource "aci_external_network_instance_profile" "exepg-default" {
#     relation_fv_rs_cons = [
#       ## Stage 2
#       aci_contract.tf-default-to-app1.id,
#       aci_contract.tf-default-to-app2.id,
#     ]
#     relation_fv_rs_prov = [
#       ## Stage 2
#       aci_contract.tf-app1-to-default.id,
#       aci_contract.tf-app2-to-default.id
#     ]
# }

### Set Output Variables for Stage 2 ###

locals {
  app1-web-net  = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app1.name,aci_application_epg.tf-app1.name])
  app1-db-net   = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app1.name,aci_application_epg.tf-app1.name])
  app2-web-net  = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app2.name,aci_application_epg.tf-app2.name])
  app2-db-net   = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app2.name,aci_application_epg.tf-app2.name])
}
