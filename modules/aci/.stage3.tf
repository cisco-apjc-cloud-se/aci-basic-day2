/*
*   Stage 3 Configuration
*/

### App #1 Web EPG
resource "aci_application_epg" "tf-app1-web" {
  application_profile_dn    = aci_application_profile.tf-app1.id
  name                      = "tf-app1-web"
  description               = "Migrated Application #1 Web Server Workloads"
  relation_fv_rs_bd         = aci_bridge_domain.tf-vlan100.id
  pref_gr_memb              = "include"

  ## Required
  # relation_fv_rs_graph_def  = ["uni/tn-common/brc-tf-default-to-vlan100/graphcont"]
  # relation_fv_rs_graph_def     = [
  #           "uni/tn-common/brc-tf-default-to-app1-web/graphcont",
  #           "uni/tn-common/brc-tf-rfc1918-to-app1-web/graphcont",
  #       ]
}

### Extend App #1 Web to VMM Domain
resource "aci_epg_to_domain" "tf-app1-web-vmm" {
  application_epg_dn    = aci_application_epg.tf-app1-web.id
  tdn                   = "uni/vmmp-VMware/dom-DVS-VMM"
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "accept"
  vmm_mac_changes       = "accept"
}

### App #1 DB EPG
resource "aci_application_epg" "tf-app1-db" {
  application_profile_dn    = aci_application_profile.tf-app1.id
  name                      = "tf-app1-db"
  description               = "Migrated Application #1 SQL Server Workloads"
  relation_fv_rs_bd         = aci_bridge_domain.tf-vlan100.id
  pref_gr_memb              = "include"

  ## Required
  # relation_fv_rs_graph_def  = ["uni/tn-common/brc-tf-default-to-vlan100/graphcont"]
  # relation_fv_rs_graph_def     = [
  #           "uni/tn-common/brc-tf-app1-web-to-db/graphcont",
  #       ]
}

### Extend App #1 DB to VMM Domain
resource "aci_epg_to_domain" "tf-app1-db-vmm" {
  application_epg_dn    = aci_application_epg.tf-app1-db.id
  tdn                   = "uni/vmmp-VMware/dom-DVS-VMM"
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "accept"
  vmm_mac_changes       = "accept"
}

### App #2 Web EPG
resource "aci_application_epg" "tf-app2-web" {
  application_profile_dn    = aci_application_profile.tf-app2.id
  name                      = "tf-app2-web"
  description               = "Migrated Application #2 Web Server Workloads"
  relation_fv_rs_bd         = aci_bridge_domain.tf-vlan100.id
  pref_gr_memb              = "include"

  ## Required
  # relation_fv_rs_graph_def  = ["uni/tn-common/brc-tf-default-to-vlan100/graphcont"]
  # relation_fv_rs_graph_def     = [
  #           "uni/tn-common/brc-tf-default-to-app2-web/graphcont",
  #           "uni/tn-common/brc-tf-rfc1918-to-app2-web/graphcont",
  #       ]
}

### Extend App #2 Web to VMM Domain
resource "aci_epg_to_domain" "tf-app2-web-vmm" {
  application_epg_dn    = aci_application_epg.tf-app2-web.id
  tdn                   = "uni/vmmp-VMware/dom-DVS-VMM"
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "accept"
  vmm_mac_changes       = "accept"
}

### App #2 DB EPG
resource "aci_application_epg" "tf-app2-db" {
  application_profile_dn    = aci_application_profile.tf-app2.id
  name                      = "tf-app2-db"
  description               = "Migrated Application #2 SQL Server Workloads"
  relation_fv_rs_bd         = aci_bridge_domain.tf-vlan100.id
  pref_gr_memb              = "include"
  
  ## Required
  # relation_fv_rs_graph_def  = ["uni/tn-common/brc-tf-default-to-vlan100/graphcont"]
  # relation_fv_rs_graph_def     = [
  #           "uni/tn-common/brc-tf-app2-web-to-db/graphcont",
  #       ]
}

### Extend App #2 DB to VMM Domain
resource "aci_epg_to_domain" "tf-app2-db-vmm" {
  application_epg_dn    = aci_application_epg.tf-app2-db.id
  tdn                   = "uni/vmmp-VMware/dom-DVS-VMM"
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "accept"
  vmm_mac_changes       = "accept"
}
