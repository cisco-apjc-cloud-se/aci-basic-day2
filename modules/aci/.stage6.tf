/*
*   Stage 6 Configuration
*/

## New Admin ExEPG
resource "aci_external_network_instance_profile" "exepg-admin" {
    l3_outside_dn       = data.aci_l3_outside.lab.id
    name                = "ADMIN"
    annotation          = ""
    pref_gr_memb        = "exclude"

    relation_fv_rs_sec_inherited = [
      aci_external_network_instance_profile.exepg-rfc1918.id
    ]

    relation_fv_rs_cons = [
      aci_contract.tf-admin-to-app.id
    ]
}

resource "aci_l3_ext_subnet" "tf-admin-laptop" {
  external_network_instance_profile_dn  = aci_external_network_instance_profile.exepg-admin.id
  name_alias          = "H-10.67.228.19-32"
  description         = "H-10.67.228.19-32"
  # aggregate          = "shared-rtctrl"
  ip                  = "10.67.228.19/32"
  scope               = ["import-security"]

}

### Contract External to App #1 Web
resource "aci_contract" "tf-admin-to-app" {
    tenant_dn   = data.aci_tenant.common.id
    description = "Contract to between Admin and App Servers"
    name        = "tf-admin-to-app"
    scope       = "global"
}

resource "aci_contract_subject" "tf-admin-to-app-sub" {
    contract_dn   = aci_contract.tf-admin-to-app.id
    description   = "Default Subject"
    name          = "defaultSub"
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-ssh.id,
    ]
}

### vzAny for Common:lab
resource "aci_any" "tf-vzany-common-lab" {
  vrf_dn       = data.aci_vrf.tf-common-lab.id
  description  = "vzAny for Common:lab VRF"

  # relation_vz_rs_any_to_cons = [
  #
  # ]

  relation_vz_rs_any_to_prov = [
    aci_contract.tf-admin-to-app.id,
  ]

}
