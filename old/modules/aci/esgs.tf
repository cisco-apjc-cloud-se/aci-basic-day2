### Create new Endpoint Security Group(s) in Tenant VRF(s) ###

// resource "aci_endpoint_security_group" "example" {
//   application_profile_dn  = aci_application_profile.example.id
//   name  = "example"
//   description = "from terraform"
//   annotation = "orchestrator:terraform"
//   name_alias = "example"
//   match_t = "AtleastOne"
//   pc_enf_pref = "unenforced"
//   pref_gr_memb = "exclude"
//
//   relation_fv_rs_scope = aci_vrf.example.id
//
//   relation_fv_rs_cons {
//     prio = "unspecified"
//     target_dn = aci_contract.example.id
//   }
//
//   relation_fv_rs_cons_if {
//     prio = "unspecified"
//     target_dn = aci_imported_contract.example.id
//   }
//
//   relation_fv_rs_cust_qos_pol = aci_resource.example.id
//
//   relation_fv_rs_intra_epg = [aci_contract.example.id]
//
//   relation_fv_rs_prov {
//     match_t = "AtleastOne"
//     prio = "unspecified"
//     target_dn = aci_contract.example.id
//   }
//
//   relation_fv_rs_sec_inherited = [aci_application_epg.example.id]
// }
