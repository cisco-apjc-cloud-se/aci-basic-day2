### Ex EPG L3 Subnet Definitions

resource "aci_l3_ext_subnet" "tf-default-0-1" {
  external_network_instance_profile_dn  = aci_external_network_instance_profile.exepg-default.id
  name_alias                            = "tf-default-l3ext"
  description                           = "Default Network 0.0.0.0/1"
  # aggregate                             = "shared-rtctrl"
  ip                                    = "0.0.0.0/1"
  # scope                                 = ["shared-rtctrl"]
  scope                                 = ["import-security"]
}

resource "aci_l3_ext_subnet" "tf-default-128-1" {
  external_network_instance_profile_dn  = aci_external_network_instance_profile.exepg-default.id
  name_alias                            = "tf-default-l3ext"
  description                           = "Default Network 128.0.0.0/1"
  # aggregate                             = "shared-rtctrl"
  ip                                    = "128.0.0.0/1"
  # scope                                 = ["shared-rtctrl"]
  scope                                 = ["import-security"]
}

resource "aci_l3_ext_subnet" "tf-rfc-1918-10" {
  external_network_instance_profile_dn  = aci_external_network_instance_profile.exepg-rfc1918.id
  name_alias          = "NET-10.0.0.0-8"
  description         = "NET-10.0.0.0-8"
  # aggregate          = "shared-rtctrl"
  ip                  = "10.0.0.0/8"
  # scope               = ["import-security","shared-security"]
  scope               = ["import-security"]
}

resource "aci_l3_ext_subnet" "tf-rfc-1918-172" {
  external_network_instance_profile_dn  = aci_external_network_instance_profile.exepg-rfc1918.id
  name_alias          = "NET-172.16.0.0-12"
  description         = "NET-172.16.0.0-12"
  # aggregate          = "shared-rtctrl"
  ip                  = "172.16.0.0/12"
  scope               = ["import-security"]
}

resource "aci_l3_ext_subnet" "tf-rfc-1918-192" {
  external_network_instance_profile_dn  = aci_external_network_instance_profile.exepg-rfc1918.id
  name_alias          = "NET-192.168.0.0-16"
  description         = "NET-192.168.0.0-16"
  # aggregate          = "shared-rtctrl"
  ip                  = "192.168.0.0/16"
  scope               = ["import-security"]
}

### Bind ExEPG to Contracts
resource "aci_external_network_instance_profile" "exepg-rfc1918" {
    l3_outside_dn       = data.aci_l3_outside.lab.id
    name                = "RFC1918"
    annotation          = ""
    pref_gr_memb        = "include"

    # relation_fv_rs_cons = [
    #   aci_contract.tf-rfc1918-to-vlan100.id,
    # ]
    # relation_fv_rs_prov = [
    #   aci_contract.tf-vlan100-to-rfc1918.id,
    # ]
}

resource "aci_external_network_instance_profile" "exepg-default" {
    l3_outside_dn       = data.aci_l3_outside.lab.id
    name                = "DEFAULT"
    annotation          = ""
    pref_gr_memb        = "include"

    # relation_fv_rs_cons = [
    #   aci_contract.tf-default-to-vlan100.id,
    # ]
    # relation_fv_rs_prov = [
    #   aci_contract.tf-vlan100-to-default.id,
    # ]
}
