### Bind ExEPG to Contracts
resource "aci_external_network_instance_profile" "exepg-rfc1918" {
    relation_fv_rs_cons = [
      ## Stage 5
      aci_contract.tf-external-to-app1-web.id,
      aci_contract.tf-external-to-app2-web.id
    ]
    relation_fv_rs_prov = [
      ## Stage 4
      aci_contract.tf-app-to-external.id
    ]
    pref_gr_memb        = "exclude"
}

resource "aci_external_network_instance_profile" "exepg-default" {
    relation_fv_rs_cons = [
      ## Stage 5
      aci_contract.tf-external-to-app1-web.id,
      aci_contract.tf-external-to-app2-web.id
    ]
    relation_fv_rs_prov = [
      ## Stage 4
      aci_contract.tf-app-to-external.id
    ]
    pref_gr_memb        = "exclude"
}

### Remove DB EPGS from Preferred Group

### App #1 Web EPG
resource "aci_application_epg" "tf-app1-web" {
  pref_gr_memb              = "exclude"
}

### App #1 DB EPG
resource "aci_application_epg" "tf-app1-db" {
  pref_gr_memb              = "exclude"
}

### App #2 Web EPG
resource "aci_application_epg" "tf-app2-web" {
  pref_gr_memb              = "exclude"
}

### App #2 DB EPG
resource "aci_application_epg" "tf-app2-db" {
  pref_gr_memb              = "exclude"
}

### Remove SSH from existing Contracts

resource "aci_contract_subject" "tf-app1-web-to-db-sub" {
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-mysql.id,
        aci_filter.tf-icmp.id
    ]
}

resource "aci_contract_subject" "tf-app2-web-to-db-sub" {
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-mysql.id,
        aci_filter.tf-icmp.id
    ]
}

resource "aci_contract_subject" "tf-external-to-app1-web-sub" {
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-web-common.id,
        aci_filter.tf-icmp.id
    ]
}

resource "aci_contract_subject" "tf-external-to-app2-web-sub" {
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-web-common.id,
        aci_filter.tf-icmp.id
    ]
}


### Set Output Variables for Stage 4 ###

locals {
  app1-web-net  = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app1.name,aci_application_epg.tf-app1-web.name])
  app1-db-net   = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app1.name,aci_application_epg.tf-app1-db.name])
  app2-web-net  = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app2.name,aci_application_epg.tf-app2-web.name])
  app2-db-net   = join("|", [aci_tenant.tf-demo.name,aci_application_profile.tf-app2.name,aci_application_epg.tf-app2-db.name])
}
