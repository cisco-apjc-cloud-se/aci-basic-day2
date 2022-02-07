/*
*   Stage 4 Configuration
*/

## Load Existing Filter
#
# data "aci_filter" "tf-common-default" {
#   tenant_dn   = data.aci_tenant.common.id
#   name        = "default"
# }

## New Filters

resource "aci_filter" "tf-mysql" {
    tenant_dn   = data.aci_tenant.common.id
    description = "MySQL filter created by terraform"
    name        = "tf-db-mysql"
}

resource "aci_filter_entry" "tf-mysql" {
    filter_dn     = aci_filter.tf-mysql.id
    description   = "Allow MySQL"
    name          = "tf-mysql"
    ether_t       = "ipv4"
    d_from_port   = "3306"
    d_to_port     = "3306"
    prot          = "tcp"
    s_from_port   = "unspecified"
    s_to_port     = "unspecified"
}

resource "aci_filter" "tf-icmp" {
    tenant_dn   = data.aci_tenant.common.id
    description = "ICMP filter created by terraform"
    name        = "tf-icmp"
}

resource "aci_filter_entry" "tf-icmp" {
    filter_dn     = aci_filter.tf-icmp.id
    description   = "Allow ICMP"
    name          = "tf-icmp"
    ether_t       = "ipv4"
    icmpv4_t      = "unspecified"
    prot          = "icmp"
}

resource "aci_filter" "tf-ssh" {
    tenant_dn   = data.aci_tenant.common.id
    description = "SSH filter created by terraform"
    name        = "tf-ssh"
}

resource "aci_filter_entry" "tf-ssh" {
  filter_dn     = aci_filter.tf-ssh.id
  description   = "Allow SSH"
  name          = "tf-ssh"
  ether_t       = "ipv4"
  d_from_port   = "22"
  d_to_port     = "22"
  prot          = "tcp"
  s_from_port   = "unspecified"
  s_to_port     = "unspecified"
}

resource "aci_filter" "tf-dns" {
    tenant_dn   = data.aci_tenant.common.id
    description = "DNS filter created by terraform"
    name        = "tf-dns"
}

resource "aci_filter_entry" "tf-dns" {
  filter_dn     = aci_filter.tf-dns.id
  description   = "Allow DNS"
  name          = "tf-ssh"
  ether_t       = "ipv4"
  d_from_port   = "53"
  d_to_port     = "53"
  prot          = "udp"
  s_from_port   = "unspecified"
  s_to_port     = "unspecified"
}


resource "aci_filter" "tf-web-common" {
    tenant_dn   = data.aci_tenant.common.id
    description = "Common Web Access Ports filter created by terraform"
    name        = "tf-web-common"
}

resource "aci_filter_entry" "tf-web-http" {
    filter_dn     = aci_filter.tf-web-common.id
    description   = "Allow HTTP"
    name          = "tf-web-http"
    ether_t       = "ipv4"
    d_from_port   = "80"
    d_to_port     = "80"
    prot          = "tcp"
    s_from_port   = "unspecified"
    s_to_port     = "unspecified"
}

resource "aci_filter_entry" "tf-web-8080" {
    filter_dn     = aci_filter.tf-web-common.id
    description   = "Allow HTTP 8080"
    name          = "tf-web-8080"
    ether_t       = "ipv4"
    d_from_port   = "8080"
    d_to_port     = "8080"
    prot          = "tcp"
    s_from_port   = "unspecified"
    s_to_port     = "unspecified"
}

resource "aci_filter_entry" "tf-web-https" {
    filter_dn     = aci_filter.tf-web-common.id
    description   = "Allow HTTPS"
    name          = "tf-web-https"
    ether_t       = "ipv4"
    d_from_port   = "443"
    d_to_port     = "443"
    prot          = "tcp"
    s_from_port   = "unspecified"
    s_to_port     = "unspecified"
}

# resource "aci_filter" "tf-icmp-echo" {
#     tenant_dn   = data.aci_tenant.common.id
#     description = "ICMP Echo filter created by terraform"
#     name        = "tf-icmp-echo"
# }
#
# resource "aci_filter_entry" "tf-icmp-echo" {
#     filter_dn     = aci_filter.tf-icmp-echo.id
#     description   = "Allow ICMP Echo"
#     name          = "tf-icmp-echo"
#     ether_t       = "ipv4"
#     icmpv4_t      = "echo"
#     prot          = "icmp"
# }

# resource "aci_filter" "tf-icmp-echo-rep" {
#     tenant_dn   = data.aci_tenant.common.id
#     description = "ICMP Echo Reply filter created by terraform"
#     name        = "tf-icmp-echo-rep"
# }
#
# resource "aci_filter_entry" "tf-icmp-echo-rep" {
#     filter_dn     = aci_filter.tf-icmp-echo-rep.id
#     description   = "Allow ICMP Echo Reply"
#     name          = "tf-icmp-echo-rep"
#     ether_t       = "ipv4"
#     icmpv4_t      = "echo-rep"
#     prot          = "icmp"
# }


## New Contracts

### Contract App #1 Web to DB
resource "aci_contract" "tf-app1-web-to-db" {
    tenant_dn   = data.aci_tenant.common.id
    description = "Contract to between App #1 Web and DB workloads"
    name        = "tf-app1-web-to-db"
    scope       = "global"
}

resource "aci_contract_subject" "tf-app1-web-to-db-sub" {
    contract_dn   = aci_contract.tf-app1-web-to-db.id
    description   = "Default Subject"
    name          = "defaultSub"
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-mysql.id,
        aci_filter.tf-ssh.id,
        aci_filter.tf-icmp.id
    ]
}

### Contract App #1 Web to DB
resource "aci_contract" "tf-app2-web-to-db" {
    tenant_dn   = data.aci_tenant.common.id
    description = "Contract to between App #2 Web and DB workloads"
    name        = "tf-app2-web-to-db"
    scope       = "global"
}

resource "aci_contract_subject" "tf-app2-web-to-db-sub" {
    contract_dn   = aci_contract.tf-app2-web-to-db.id
    description   = "Default Subject"
    name          = "defaultSub"
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-mysql.id,
        aci_filter.tf-ssh.id,
        aci_filter.tf-icmp.id
    ]
}

### Contract Apps to External
resource "aci_contract" "tf-app-to-external" {
    tenant_dn   = data.aci_tenant.common.id
    description = "Contract to allow external access"
    name        = "tf-app-to-external"
    scope       = "global"
}

resource "aci_contract_subject" "tf-app-to-external-sub" {
    contract_dn   = aci_contract.tf-app-to-external.id
    description   = "Default Subject"
    name          = "defaultSub"
    relation_vz_rs_subj_filt_att = [
        aci_filter.tf-icmp.id,
        aci_filter.tf-dns.id,
        aci_filter.tf-web-common.id
    ]
}

# ### Contract External to Apps
# resource "aci_contract" "tf-external-to-app" {
#     tenant_dn   = data.aci_tenant.common.id
#     description = "Contract to allow external ICMP reply traffic"
#     name        = "tf-external-to-app"
#     scope       = "global"
# }
#
# resource "aci_contract_subject" "tf-external-to-app-sub" {
#     contract_dn   = aci_contract.tf-external-to-app.id
#     description   = "Default Subject"
#     name          = "defaultSub"
#     relation_vz_rs_subj_filt_att = [
#         aci_filter.tf-icmp-echo-rep.id,
#     ]
# }

### Bind EPGs to Contracts
resource "aci_epg_to_contract" "tf-app1-web-to-db-c" {
    application_epg_dn = aci_application_epg.tf-app1-web.id
    contract_dn  = aci_contract.tf-app1-web-to-db.id
    contract_type = "consumer"
}

resource "aci_epg_to_contract" "tf-app1-web-to-db-p" {
    application_epg_dn = aci_application_epg.tf-app1-db.id
    contract_dn  = aci_contract.tf-app1-web-to-db.id
    contract_type = "provider"
}

resource "aci_epg_to_contract" "tf-app2-web-to-db-c" {
    application_epg_dn = aci_application_epg.tf-app2-web.id
    contract_dn  = aci_contract.tf-app2-web-to-db.id
    contract_type = "consumer"
}

resource "aci_epg_to_contract" "tf-app2-web-to-db-p" {
    application_epg_dn = aci_application_epg.tf-app2-db.id
    contract_dn  = aci_contract.tf-app2-web-to-db.id
    contract_type = "provider"
}


### Apps to External
resource "aci_epg_to_contract" "tf-app-to-external-c1" {
    application_epg_dn = aci_application_epg.tf-app1-db.id
    contract_dn  = aci_contract.tf-app-to-external.id
    contract_type = "consumer"
}

resource "aci_epg_to_contract" "tf-app-to-external-c2" {
    application_epg_dn = aci_application_epg.tf-app2-db.id
    contract_dn  = aci_contract.tf-app-to-external.id
    contract_type = "consumer"
}

# ### External to App
# resource "aci_epg_to_contract" "tf-app-to-external-p1" {
#     application_epg_dn = aci_application_epg.tf-app1-db.id
#     contract_dn  = aci_contract.tf-app-to-external.id
#     contract_type = "provider"
# }
#
# resource "aci_epg_to_contract" "tf-app-to-external-p2" {
#     application_epg_dn = aci_application_epg.tf-app2-db.id
#     contract_dn  = aci_contract.tf-app-to-external.id
#     contract_type = "provider"
# }
