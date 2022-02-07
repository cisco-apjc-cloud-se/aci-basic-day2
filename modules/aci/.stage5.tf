/*
*   Stage 5 Configuration
*/

## New Contracts

### Contract External to App #1 Web
resource "aci_contract" "tf-external-to-app1-web" {
    tenant_dn   = data.aci_tenant.common.id
    description = "Contract to between External and App #1 Web"
    name        = "tf-external-to-app1-web"
    scope       = "global"
}

resource "aci_contract_subject" "tf-external-to-app1-web-sub" {
    contract_dn   = aci_contract.tf-external-to-app1-web.id
    description   = "Default Subject"
    name          = "defaultSub"
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-web-common.id,
        aci_filter.tf-ssh.id,
        aci_filter.tf-icmp.id
    ]
}

### Contract External to App #2 Web
resource "aci_contract" "tf-external-to-app2-web" {
    tenant_dn   = data.aci_tenant.common.id
    description = "Contract to between External and App #2 Web"
    name        = "tf-external-to-app2-web"
    scope       = "global"
}

resource "aci_contract_subject" "tf-external-to-app2-web-sub" {
    contract_dn   = aci_contract.tf-external-to-app2-web.id
    description   = "Default Subject"
    name          = "defaultSub"
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-web-common.id,
        aci_filter.tf-ssh.id,
        aci_filter.tf-icmp.id
    ]
}


### Bind EPGs to Contracts
resource "aci_epg_to_contract" "tf-external-to-app1-web-p" {
    application_epg_dn = aci_application_epg.tf-app1-web.id
    contract_dn  = aci_contract.tf-external-to-app1-web.id
    contract_type = "provider"
}

resource "aci_epg_to_contract" "tf-external-to-app2-web-p" {
    application_epg_dn = aci_application_epg.tf-app2-web.id
    contract_dn  = aci_contract.tf-external-to-app2-web.id
    contract_type = "provider"
}


### Apps to External
resource "aci_epg_to_contract" "tf-app-to-external-c3" {
    application_epg_dn = aci_application_epg.tf-app1-web.id
    contract_dn  = aci_contract.tf-app-to-external.id
    contract_type = "consumer"
}

resource "aci_epg_to_contract" "tf-app-to-external-c4" {
    application_epg_dn = aci_application_epg.tf-app2-web.id
    contract_dn  = aci_contract.tf-app-to-external.id
    contract_type = "consumer"
}
