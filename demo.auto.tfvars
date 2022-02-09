### Existing VMM Domain Name ###
vmm_name = "DVS-VMM"

### Tenants ###
tenants = {
  demo-basic-1 = {
    name = "demo-basic-1"
    description = "Basic ACI Tenant #1 built from Terraform Cloud"
  }
  demo-basic-2 = {
    name = "demo-basic-2"
    description = "Basic ACI Tenant #2 built from Terraform Cloud"
  }
}

### VRFs ###
vrfs = {
  vrf-1 = {
    vrf_name    = "vrf-1"
    description = "VRF #1 for Tenant #1"
    tenant_name = "demo-basic-1" ## Tenant to add VRF to
  }
  vrf-2 = {
    vrf_name    = "vrf-2"
    description = "VRF #2 for Tenant #1"
    tenant_name = "demo-basic-1" ## Tenant to add VRF to
  }
}

### Bridge Domains & L3 Subnets ###
bds = {
  bd-1 = {
    bd_name     = "bd-1"
    vrf_name    = "vrf-1"      ## VRF to add BD to
    description = "Demo Bridge Domain #1 for Tenant #1"
    tenant_name = "demo-basic-1"    ## Tenant to add VRF to
    subnets = {
      sub-1 = {
        ip          = "192.168.1.1/24"
        description = "Primary Subnet for BD#1"
        scope       = ["public"]
        preferred   = "yes"
      },
      sub-2 = {
        ip          = "192.168.101.1/24"
        description = "Secondary Subnet for BD#1"
        scope       = ["public"]
        preferred   = "no"
      }
    }
  }
  bd-2 = {
    bd_name     = "bd-2"
    vrf_name    = "vrf-1"      ## VRF to add BD to
    description = "Demo Bridge Domain #2 for Tenant #1"
    tenant_name = "demo-basic-1"    ## Tenant to add VRF to
    subnets     = {}
  }
}

### Application Profiles & End Point Groups ###
aps = {
  ap-1 = {
    ap_name = "ap-1"
    tenant_name = "demo-basic-1"    ## Tenant to add AP to
    description = "App Profile #1 for Tenant #1"
    epgs = {
      epg-1 = {
        epg_name = "epg-1"
        bd_name = "bd-1"       ## Bridge Domain to add EPG to
        description = "Demo EPG #1 in BD #1"
        vmm_enabled = true
        paths = {
          path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
            pod       = 1
            leaf_node = 101
            port      = "Eth1/10"
            vlan_id   = 333
            mode      = "regular" # regular, native, untagged
          }
          path2 = { # topology/pod-1/paths-101/pathep-[eth1/23]
            pod       = 1
            leaf_node = 102
            port      = "Eth1/10"
            vlan_id   = 333
            mode      = "regular" # regular, native, untagged
          }
        }
      }
      epg-2 = {
        epg_name = "epg-2"
        bd_name = "bd-1"       ## Bridge Domain to add EPG to
        description = "Demo EPG #2 in BD #1"
        vmm_enabled = true
        paths = {}
      }
    }
  }
}

### Filters ###
filters = {
  allow-ipv4 = {
    filter_name = "allow-ipv4"
    description = "Allow all IPv4 traffic"
    tenant_name = "demo-basic-1"    ## Tenant to add filter to
    entries = {
      all-ip = {
        name = "all-ip"
        description = "Allow all IPv4 traffic"
        ether_t       = "ipv4"
        d_from_port   = "unspecified"
        d_to_port     = "unspecified"
        prot          = "unspecified"
        s_from_port   = "unspecified"
        s_to_port     = "unspecified"
      }
    }
  },
  allow-mysql = {
    filter_name = "allow-mysql"
    description = "Allow MySQL TCP 3306 traffic"
    tenant_name = "demo-basic-1"    ## Tenant to add filter to
    entries = {
      mysql = {
        name = "mysql"
        description = "Allow MySQL TCP 3306 traffic"
        ether_t       = "ipv4"
        d_from_port   = "3306"
        d_to_port     = "3306"
        prot          = "tcp"
        s_from_port   = "unspecified"
        s_to_port     = "unspecified"
      }
    }
  },
  allow-ssh = {
    filter_name = "allow-ssh"
    description = "Allow SSH traffic"
    tenant_name = "demo-basic-1"    ## Tenant to add filter to
    entries = {
      ssh = {
        name = "ssh"
        description = "Allow SSH traffic"
        ether_t       = "ipv4"
        d_from_port   = "ssh" # 22
        d_to_port     = "ssh" # 22
        prot          = "tcp"
        s_from_port   = "unspecified"
        s_to_port     = "unspecified"
      }
    }
  },
  allow-web = {
    filter_name = "allow-web"
    description = "Allow Web traffic on TCP 80, 443 and 8080"
    tenant_name = "demo-basic-1"    ## Tenant to add filter to
    entries = {
      http = {
        name = "http"
        description = "Allow HTTP TCP 80 traffic"
        ether_t       = "ipv4"
        d_from_port   = "http" # 80
        d_to_port     = "http" # 80
        prot          = "tcp"
        s_from_port   = "unspecified"
        s_to_port     = "unspecified"
      },
      https = {
        name = "https"
        description = "Allow HTTPS TCP 443 traffic"
        ether_t       = "ipv4"
        d_from_port   = "https" # 443
        d_to_port     = "https" # 443
        prot          = "tcp"
        s_from_port   = "unspecified"
        s_to_port     = "unspecified"
      },
      http-8080 = {
        name = "http-8080"
        description = "Allow HTTP TCP 8080 traffic"
        ether_t       = "ipv4"
        d_from_port   = "8080"
        d_to_port     = "8080"
        prot          = "tcp"
        s_from_port   = "unspecified"
        s_to_port     = "unspecified"
      }
    }
  }
}


### Contracts ###
contracts = {
  epg1-to-epg2 = {
    contract_name = "epg1-to-epg2"
    description   = "Allow traffic from EPG#1 to EPG#2"
    tenant_name   = "demo-basic-1"    ## Tenant to add filter to
    scope         = "tenant" # "global", "tenant", "application-profile" and "context"
    filters = [
      "allow-ipv4"
    ]
  },
  exepg1-to-epg1 = {
    contract_name = "exepg1-to-epg1"
    description   = "Allow traffic from External EPG#1 to EPG#1"
    tenant_name   = "demo-basic-1"    ## Tenant to add filter to
    scope         = "tenant" # "global", "tenant", "application-profile" and "context"
    filters = [
      "allow-ipv4"
    ]
  },
  exepg1-to-epg2 = {
    contract_name = "exepg1-to-epg2"
    description   = "Allow traffic from External EPG#1 to EPG#2"
    tenant_name   = "demo-basic-1"    ## Tenant to add filter to
    scope         = "tenant" # "global", "tenant", "application-profile" and "context"
    filters = [
      "allow-ipv4"
    ]
  }
}

### L3Outs & External EPGs ###
l3outs = {
  demo-l3out = {
    l3out_name      = "demo-l3out"
    description     = "Demo L3Out built from Terraform"
    tenant_name     = "demo-basic-1"    ## Tenant to add filter to
    vrf_name        = "vrf-1"
    logical_profiles = {
      demo-l3out = {
        lprof_name  = "demo-l3out"
        description = "Demo L3Out Logical Profile created from Terraform"
        interface_profiles = {
          demo-l3out-intprof = {
            intprof_name  = "demo-l3out-intprof"
            description   = "Demo L3Out Logical Interface Profile created from Terraform"
            paths = {
              path-1 = {
                description     = "Demo L3 SVI Path"
                type            = "ext-svi"
                ip              = "192.168.255.1/30"
                vlan_id         = 302
                pod             = 1
                leaf_node       = path.leaf_node
                port            = path.port
              }
            }
          }
        }
      }
    }
    extepgs = {
      rfc1918 = {
        extepg_name         = "rfc1918"
        description         = "External users in RFC1918 subnets"
        preferred_group     = "exclude"
        consumed_contracts  = []
        provided_contracts  = []
        subnets = {
          N-10-0-0-0-8 = {
            description = "10.0.0.0/8"
            aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
            ip = "10.0.0.0/8"
            scope = ["import-security","shared-security"]
          },
          N-172-16-0-0-12 = {
            description = "172.16.0.0/12"
            aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
            ip = "172.16.0.0/12"
            scope = ["import-security","shared-security"]
          },
          N-192-168-0-0-16 = {
            description = "192.168.0.0/16"
            aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
            ip = "192.168.0.0/16"
            scope = ["import-security","shared-security"]
          }
        }
      }
    }
  }
}
