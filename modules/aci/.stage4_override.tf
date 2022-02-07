### Bind ExEPG to Contracts
resource "aci_external_network_instance_profile" "exepg-rfc1918" {
    # relation_fv_rs_cons = [
    #   ## Stage 4
    #   aci_contract.tf-external-to-app.id
    # ]
    relation_fv_rs_prov = [
      ## Stage 4
      aci_contract.tf-app-to-external.id
    ]
}

resource "aci_external_network_instance_profile" "exepg-default" {
    # relation_fv_rs_cons = [
    #   ## Stage 4
    #   aci_contract.tf-external-to-app.id
    # ]
    relation_fv_rs_prov = [
      ## Stage 4
      aci_contract.tf-app-to-external.id
    ]
}

### Remove DB EPGS from Preferred Group

### App #1 DB EPG
resource "aci_application_epg" "tf-app1-db" {
  pref_gr_memb              = "exclude"
}

### App #2 DB EPG
resource "aci_application_epg" "tf-app2-db" {
  pref_gr_memb              = "exclude"
}

### Set Output Variables for Stage 4 ###

locals {
  app1-web-net  = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app1.name,aci_application_epg.tf-app1-web.name])
  app1-db-net   = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app1.name,aci_application_epg.tf-app1-db.name])
  app2-web-net  = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app2.name,aci_application_epg.tf-app2-web.name])
  app2-db-net   = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app2.name,aci_application_epg.tf-app2-db.name])
}
