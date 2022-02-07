/*
*   Stage 2b Configuration
*/

### App #1 EPG
resource "aci_application_epg" "tf-app1" {
  application_profile_dn    = aci_application_profile.tf-app1.id
  name                      = "tf-app1"
  description               = "Migrated Application #1 Workloads"
  relation_fv_rs_bd         = aci_bridge_domain.tf-vlan100.id
  pref_gr_memb              = "include"

  ## Required
  # relation_fv_rs_graph_def  = ["uni/tn-common/brc-tf-default-to-vlan100/graphcont"]
  # relation_fv_rs_graph_def     = [
  #         "uni/tn-common/brc-tf-default-to-app1/graphcont",
  #         "uni/tn-common/brc-tf-rfc1918-to-app1/graphcont",
  #       ]
}

### Extend App #1 to VMM Domain
resource "aci_epg_to_domain" "tf-app1-vmm" {
  application_epg_dn    = aci_application_epg.tf-app1.id
  tdn                   = "uni/vmmp-VMware/dom-DVS-VMM"
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "accept"
  vmm_mac_changes       = "accept"
}

### App #2 EPG
resource "aci_application_epg" "tf-app2" {
  application_profile_dn    = aci_application_profile.tf-app2.id
  name                      = "tf-app2"
  description               = "Migrated Application #2 Workloads"
  relation_fv_rs_bd         = aci_bridge_domain.tf-vlan100.id
  pref_gr_memb              = "include"

  ## Required
  # relation_fv_rs_graph_def  = ["uni/tn-common/brc-tf-default-to-vlan100/graphcont"]
  # relation_fv_rs_graph_def     = [
  #         "uni/tn-common/brc-tf-default-to-app2/graphcont",
  #         "uni/tn-common/brc-tf-rfc1918-to-app2/graphcont",
  #       ]
}

### Extend App #2 to VMM Domain
resource "aci_epg_to_domain" "tf-app2-vmm" {
  application_epg_dn    = aci_application_epg.tf-app2.id
  tdn                   = "uni/vmmp-VMware/dom-DVS-VMM"
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "accept"
  vmm_mac_changes       = "accept"
}
