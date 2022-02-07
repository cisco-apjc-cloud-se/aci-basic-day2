// /*
// *   Stage 1 Configuration
// */
//
// ### Application Profile
// resource "aci_application_profile" "tf-migrated-vlans" {
//   tenant_dn   = aci_tenant.tf-demo.id
//   name        = "tf-migrated-vlans"
//   description = "Migrated VLANs"
// }
//
// ### VLAN 100 EPG
// resource "aci_application_epg" "tf-vlan100" {
//   application_profile_dn    = aci_application_profile.tf-migrated-vlans.id
//   name                      = "tf-vlan100"
//   description               = "Migrated VLAN 100 Workloads"
//   relation_fv_rs_bd         = aci_bridge_domain.tf-vlan100.id
//   pref_gr_memb              = "include"
//
//   ## Required?
//   # relation_fv_rs_graph_def     = [
//   #         "uni/tn-common/brc-tf-default-to-vlan100/graphcont",
//   #         "uni/tn-common/brc-tf-rfc1918-to-vlan100/graphcont",
//   #       ]
// }
//
// ### Extend to VMM Domain
// resource "aci_epg_to_domain" "tf-vlan100-vmm" {
//   application_epg_dn    = aci_application_epg.tf-vlan100.id
//   tdn                   = "uni/vmmp-VMware/dom-DVS-VMM"
//   vmm_allow_promiscuous = "accept"
//   vmm_forged_transmits  = "accept"
//   vmm_mac_changes       = "accept"
// }
//
// # ### Static EPG Mapping
// #
// # ### Contract Default in to VLAN 100
// # resource "aci_contract" "tf-default-to-vlan100" {
// #     tenant_dn   = data.aci_tenant.common.id
// #     description = "Contract to L3 access to migrated VLAN 100 workloads"
// #     name        = "tf-default-to-vlan100"
// #     scope       = "global"
// # }
// #
// # resource "aci_contract_subject" "tf-default-to-vlan100-sub" {
// #     contract_dn   = aci_contract.tf-default-to-vlan100.id
// #     description   = "Default Subject"
// #     name          = "defaultSub"
// #     relation_vz_rs_subj_filt_att = [data.aci_filter.tf-common-default.id]
// # }
// #
// # ### Contract VLAN 100 out to Default
// # resource "aci_contract" "tf-vlan100-to-default" {
// #     tenant_dn   = data.aci_tenant.common.id
// #     description = "Contract to L3 access to migrated VLAN 100 workloads"
// #     name        = "tf-vlan100-to-default"
// #     scope       = "global"
// # }
// #
// # resource "aci_contract_subject" "tf-vlan100-to-default-sub" {
// #     contract_dn   = aci_contract.tf-vlan100-to-default.id
// #     description   = "Default Subject"
// #     name          = "defaultSub"
// #     rev_flt_ports = "no"
// #     relation_vz_rs_subj_filt_att = [data.aci_filter.tf-common-default.id]
// # }
// #
// # ### Contract RFC1918 in to VLAN 100
// # resource "aci_contract" "tf-rfc1918-to-vlan100" {
// #     tenant_dn   = data.aci_tenant.common.id
// #     description = "Contract to L3 access to migrated VLAN 100 workloads"
// #     name        = "tf-rfc1918-to-vlan100"
// #     scope       = "global"
// # }
// #
// # resource "aci_contract_subject" "tf-rfc1918-to-vlan100-sub" {
// #     contract_dn   = aci_contract.tf-rfc1918-to-vlan100.id
// #     description   = "Default Subject"
// #     name          = "defaultSub"
// #     rev_flt_ports = "no"
// #     relation_vz_rs_subj_filt_att = [data.aci_filter.tf-common-default.id]
// # }
// #
// # ### Contract VLAN 100 out to RFC1918
// # resource "aci_contract" "tf-vlan100-to-rfc1918" {
// #     tenant_dn   = data.aci_tenant.common.id
// #     description = "Contract to L3 access to migrated VLAN 100 workloads"
// #     name        = "tf-vlan100-to-rfc1918"
// #     scope       = "global"
// # }
// #
// # resource "aci_contract_subject" "tf-vlan100-to-rfc1918-sub" {
// #     contract_dn   = aci_contract.tf-vlan100-to-rfc1918.id
// #     description   = "Default Subject"
// #     name          = "defaultSub"
// #     relation_vz_rs_subj_filt_att = [data.aci_filter.tf-common-default.id]
// # }
// #
// # ### Bind EPGs to Contracts
// # resource "aci_epg_to_contract" "tf-default-to-vlan100" {
// #     application_epg_dn = aci_application_epg.tf-vlan100.id
// #     contract_dn  = aci_contract.tf-default-to-vlan100.id
// #     contract_type = "provider"
// # }
// #
// # resource "aci_epg_to_contract" "tf-vlan100-to-default" {
// #     application_epg_dn = aci_application_epg.tf-vlan100.id
// #     contract_dn  = aci_contract.tf-vlan100-to-default.id
// #     contract_type = "consumer"
// # }
// #
// # resource "aci_epg_to_contract" "tf-rfc1918-to-vlan100" {
// #     application_epg_dn = aci_application_epg.tf-vlan100.id
// #     contract_dn  = aci_contract.tf-rfc1918-to-vlan100.id
// #     contract_type = "provider"
// # }
// #
// # resource "aci_epg_to_contract" "tf-vlan100-to-rfc1918" {
// #     application_epg_dn = aci_application_epg.tf-vlan100.id
// #     contract_dn  = aci_contract.tf-vlan100-to-rfc1918.id
// #     contract_type = "consumer"
// # }
