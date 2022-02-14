### Existing VMM Domain Name ###
vmm_name = "DVS-VMM"

### Existing Physical Domain Name ###
phys_name = "LAB-N9348"

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
    preferred_group = "enabled"
  }
}

### Bridge Domains & L3 Subnets ###
bds = {
  bd-303 = {
    bd_name     = "bd-303"
    vrf_name    = "vrf-1"      ## VRF to add BD to
    description = " Bridge Domain for Legacy VLAN 303 in Tenant #1"
    tenant_name = "demo-basic-1"    ## Tenant to add VRF to
    arp_flood   = "no" ## "yes", "no"
    mac_address = "00:00:0C:9F:F1:2F"  ## HSRP v2 MAC!
    l3outs      = ["demo-l3out"] ## List of associated L3outs for BD's Subnets
    subnets = {
      sub-1 = {
        ip          = "10.66.209.81/28"
        description = "Primary Subnet for BD VLAN 303"
        scope       = ["public"]
        preferred   = "yes"
      }
    }
  }
  bd-304 = {
    bd_name     = "bd-304"
    vrf_name    = "vrf-1"      ## VRF to add BD to
    description = " Bridge Domain for Legacy VLAN 304 in Tenant #1"
    tenant_name = "demo-basic-1"    ## Tenant to add VRF to
    arp_flood   = "no" ## "yes", "no"
    mac_address = "00:00:0C:9F:F1:30"  ## HSRP v2 MAC!
    l3outs      = ["demo-l3out"] ## List of associated L3outs for BD's Subnets
    subnets = {
      sub-1 = {
        ip          = "10.66.209.97/28"
        description = "Primary Subnet for BD VLAN 304"
        scope       = ["public"]
        preferred   = "yes"
      }
    }
  }
}

### Application Profiles & End Point Groups ###
aps = {
  app-1 = {
    ap_name = "app-1"
    tenant_name = "demo-basic-1"    ## Tenant to add AP to
    description = "App Profile for Separated App #1"
    esgs = {
      ### Stage 4 - Tidy-up Legacy ESG ###
      # app-1 = {
      #   esg_name        = "app-1"
      #   description     = "App #1 ESG"
      #   preferred_group = "include"
      #   vrf_name        = "vrf-1"
      #   consumed_contracts = {}
      #   provided_contracts = {}
      # }
      ### Stage 4 - Add Contracts to ESGs ###
      web = {
        esg_name        = "web"
        description     = "App #1 Web Tier ESG"
        preferred_group = "exclude"
        vrf_name        = "vrf-1"
        consumed_contracts = {
          cons-1 = {
            contract_name = "app1-web-to-db"
          }
        }
        provided_contracts = {
          prov-1 = {
            contract_name = "rfc1918-to-web"
          }
        }
      }
      db = {
        esg_name        = "db"
        description     = "App #1 DB Tier ESG"
        preferred_group = "exclude"
        vrf_name        = "vrf-1"
        consumed_contracts = {}
        provided_contracts = {
          prov-1 = {
            contract_name = "app1-web-to-db"
          }
          prov-2 = {
            contract_name = "dbadmins-to-db"
          }
        }
      }
    }
    epgs = {
      ### Stage 4 - Tidy-up Legacy EPG ###
      # app-1 = {
      #   epg_name = "app-1"
      #   bd_name = "bd-303"       ## Bridge Domain to add EPG to
      #   description = "App #1 EPG"
      #   vmm_enabled = true
      #   mapped_esg = "app-1" # "esg-1"
      #   preferred_group = "include"  ## Must be the same as ESG!
      #   paths = {}
      # }
      web = {
        epg_name = "web"
        bd_name = "bd-303"       ## Bridge Domain to add EPG to
        description = "App #1 Web Tier EPG"
        vmm_enabled = true
        mapped_esg = "web" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG initially
        paths = {}
      }
      db = {
        epg_name = "db"
        bd_name = "bd-303"       ## Bridge Domain to add EPG to
        description = "App #1 DB Tier EPG"
        vmm_enabled = true
        mapped_esg = "db" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG initially
        paths = {}
      }
    }
  }
  app-2 = {
    ap_name = "app-2"
    tenant_name = "demo-basic-1"    ## Tenant to add AP to
    description = "App Profile for Separated App #2"
    esgs = {
      ### Stage 4 - Tidy-up Legacy ESG ###
      # app-2 = {
      #   esg_name        = "app-2"
      #   description     = "App #2 ESG"
      #   preferred_group = "include"
      #   vrf_name        = "vrf-1"
      #   consumed_contracts = {}
      #   provided_contracts = {}
      # }
      ### Stage 3 - New Web & DB Tier ESGs ###
      web = {
        esg_name        = "web"
        description     = "App #2 Web Tier ESG"
        preferred_group = "exclude"
        vrf_name        = "vrf-1"
        consumed_contracts = {
          cons-1 = {
            contract_name = "app2-web-to-db"
          }
        }
        provided_contracts = {
          prov-1 = {
            contract_name = "rfc1918-to-web"
          }
        }
      }
      db = {
        esg_name        = "db"
        description     = "App #2 DB Tier ESG"
        preferred_group = "exclude"
        vrf_name        = "vrf-1"
        consumed_contracts = {}
        provided_contracts = {
          prov-1 = {
            contract_name = "app2-web-to-db"
          }
          prov-2 = {
            contract_name = "dbadmins-to-db"
          }
        }
      }
    }
    epgs = {
      ### Stage 4 - Tidy-up Legacy EPG ###
      # app-2 = {
      #   epg_name = "app-2"
      #   bd_name = "bd-303"       ## Bridge Domain to add EPG to
      #   description = "App #2 EPG"
      #   vmm_enabled = true
      #   mapped_esg = "app-2" # "esg-1"
      #   preferred_group = "include"  ## Must be the same as ESG!
      #   paths = {}
      # }
      web = {
        epg_name = "web"
        bd_name = "bd-303"       ## Bridge Domain to add EPG to
        description = "App #2 Web Tier EPG"
        vmm_enabled = true
        mapped_esg = "web" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG initially
        paths = {}
      }
      db = {
        epg_name = "db"
        bd_name = "bd-303"       ## Bridge Domain to add EPG to
        description = "App #2 DB Tier EPG"
        vmm_enabled = true
        mapped_esg = "db" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG initially
        paths = {}
      }
    }
  }
  app-3 = {
    ap_name = "app-3"
    tenant_name = "demo-basic-1"    ## Tenant to add AP to
    description = "App Profile for Separated App #3"
    esgs = {
      ### Stage 4 - Tidy-up Legacy ESG ###
      # app-3 = {
      #   esg_name        = "app-3"
      #   description     = "App #3 ESG"
      #   preferred_group = "include"
      #   vrf_name        = "vrf-1"
      #   consumed_contracts = {}
      #   provided_contracts = {}
      # }
      ### Stage 3 - New Web & DB Tier ESGs ###
      web = {
        esg_name        = "web"
        description     = "App #3 Web Tier ESG"
        preferred_group = "exclude"
        vrf_name        = "vrf-1"
        consumed_contracts = {
          cons-1 = {
            contract_name = "app3-web-to-db"
          }
        }
        provided_contracts = {
          prov-1 = {
            contract_name = "rfc1918-to-web"
          }
        }
      }
      db = {
        esg_name        = "db"
        description     = "App #3 DB Tier ESG"
        preferred_group = "exclude"
        vrf_name        = "vrf-1"
        consumed_contracts = {}
        provided_contracts = {
          prov-1 = {
            contract_name = "app3-web-to-db"
          }
          prov-2 = {
            contract_name = "dbadmins-to-db"
          }
        }
      }
    }
    epgs = {
      ### Stage 4 - Tidy-up Legacy EPG ###
      # app-3 = {
      #   epg_name = "app-3"
      #   bd_name = "bd-304"       ## Bridge Domain to add EPG to
      #   description = "App #3 EPG"
      #   vmm_enabled = true
      #   mapped_esg = "app-3" # "esg-1"
      #   preferred_group = "include"  ## Must be the same as ESG!
      #   paths = {}
      # }
      web = {
        epg_name = "web"
        bd_name = "bd-304"       ## Bridge Domain to add EPG to
        description = "App #3 Web Tier EPG"
        vmm_enabled = true
        mapped_esg = "web" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG initially
        paths = {}
      }
      db = {
        epg_name = "db"
        bd_name = "bd-304"       ## Bridge Domain to add EPG to
        description = "App #3 DB Tier EPG"
        vmm_enabled = true
        mapped_esg = "db" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG initially
        paths = {}
      }
    }
  }
  app-4 = {
    ap_name = "app-4"
    tenant_name = "demo-basic-1"    ## Tenant to add AP to
    description = "App Profile for Separated App #4"
    esgs = {
      ### Stage 4 - Tidy-up Legacy ESG ###
      # app-4 = {
      #   esg_name        = "app-4"
      #   description     = "App #4 ESG"
      #   preferred_group = "include"
      #   vrf_name        = "vrf-1"
      #   consumed_contracts = {}
      #   provided_contracts = {}
      # }
      ### Stage 4 - Add Contracts - Remove Preferred Group ###
      web = {
        esg_name        = "web"
        description     = "App #4 Web Tier ESG"
        preferred_group = "exclude"
        vrf_name        = "vrf-1"
        consumed_contracts = {
          cons-1 = {
            contract_name = "app4-web-to-db"
          }
        }
        provided_contracts = {
          prov-1 = {
            contract_name = "rfc1918-to-web"
          }
          prov-2 = {
            contract_name = "dbadmins-to-db"
          }
        }
      }
      db = {
        esg_name        = "db"
        description     = "App #4 DB Tier ESG"
        preferred_group = "exclude"
        vrf_name        = "vrf-1"
        consumed_contracts = {}
        provided_contracts = {
          prov-1 = {
            contract_name = "app4-web-to-db"
          }
        }
      }
    }
    epgs = {
      ### Stage 4 - Tidy-up Legacy EPG ###
      # app-4 = {
      #   epg_name = "app-4"
      #   bd_name = "bd-304"       ## Bridge Domain to add EPG to
      #   description = "App #4 EPG"
      #   vmm_enabled = true
      #   mapped_esg = "app-4" # "esg-1"
      #   preferred_group = "include"  ## Must be the same as ESG!
      #   paths = {}
      # }
      web = {
        epg_name = "web"
        bd_name = "bd-304"       ## Bridge Domain to add EPG to
        description = "App #4 Web Tier EPG"
        vmm_enabled = true
        mapped_esg = "web" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG initially
        paths = {}
      }
      db = {
        epg_name = "db"
        bd_name = "bd-304"       ## Bridge Domain to add EPG to
        description = "App #4 DB Tier EPG"
        vmm_enabled = true
        mapped_esg = "db" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG initially
        paths = {}
      }
    }
  }
}

### Filters ###
filters = {
  ### STAGE 4 - Add New Filters ###
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
  }
  # allow-mysql = {
  #   filter_name = "allow-mysql"
  #   description = "Allow MySQL TCP 3306 traffic"
  #   tenant_name = "demo-basic-1"    ## Tenant to add filter to
  #   entries = {
  #     mysql = {
  #       name = "mysql"
  #       description = "Allow MySQL TCP 3306 traffic"
  #       ether_t       = "ipv4"
  #       d_from_port   = "3306"
  #       d_to_port     = "3306"
  #       prot          = "tcp"
  #       s_from_port   = "unspecified"
  #       s_to_port     = "unspecified"
  #     }
  #   }
  # }
  # allow-ssh = {
  #   filter_name = "allow-ssh"
  #   description = "Allow SSH traffic"
  #   tenant_name = "demo-basic-1"    ## Tenant to add filter to
  #   entries = {
  #     ssh = {
  #       name = "ssh"
  #       description = "Allow SSH traffic"
  #       ether_t       = "ipv4"
  #       d_from_port   = "ssh" # 22
  #       d_to_port     = "ssh" # 22
  #       prot          = "tcp"
  #       s_from_port   = "unspecified"
  #       s_to_port     = "unspecified"
  #     }
  #   }
  # }
  # allow-web = {
  #   filter_name = "allow-web"
  #   description = "Allow Web traffic on TCP 80, 443 and 8080"
  #   tenant_name = "demo-basic-1"    ## Tenant to add filter to
  #   entries = {
  #     http = {
  #       name = "http"
  #       description = "Allow HTTP TCP 80 traffic"
  #       ether_t       = "ipv4"
  #       d_from_port   = "http" # 80
  #       d_to_port     = "http" # 80
  #       prot          = "tcp"
  #       s_from_port   = "unspecified"
  #       s_to_port     = "unspecified"
  #     },
  #     https = {
  #       name = "https"
  #       description = "Allow HTTPS TCP 443 traffic"
  #       ether_t       = "ipv4"
  #       d_from_port   = "https" # 443
  #       d_to_port     = "https" # 443
  #       prot          = "tcp"
  #       s_from_port   = "unspecified"
  #       s_to_port     = "unspecified"
  #     },
  #     http-8080 = {
  #       name = "http-8080"
  #       description = "Allow HTTP TCP 8080 traffic"
  #       ether_t       = "ipv4"
  #       d_from_port   = "8080"
  #       d_to_port     = "8080"
  #       prot          = "tcp"
  #       s_from_port   = "unspecified"
  #       s_to_port     = "unspecified"
  #     }
  #   }
  # }
}


### Contracts ###
### STAGE 4 - Add New Contracts ###
contracts = {
  app1-web-to-db = {
    contract_name = "app1-web-to-db"
    description   = "Allow all traffic from Web to DB Tier"
    tenant_name   = "demo-basic-1"    ## Tenant to add filter to
    scope         = "tenant" # "global", "tenant", "application-profile" and "context"
    filters = [
      "allow-ipv4"
    ]
  }
  app2-web-to-db = {
    contract_name = "app2-web-to-db"
    description   = "Allow all traffic from Web to DB Tier"
    tenant_name   = "demo-basic-1"    ## Tenant to add filter to
    scope         = "tenant" # "global", "tenant", "application-profile" and "context"
    filters = [
      "allow-ipv4"
    ]
  }
  app3-web-to-db = {
    contract_name = "app2-web-to-db"
    description   = "Allow all traffic from Web to DB Tier"
    tenant_name   = "demo-basic-1"    ## Tenant to add filter to
    scope         = "tenant" # "global", "tenant", "application-profile" and "context"
    filters = [
      "allow-ipv4"
    ]
  }
  app4-web-to-db = {
    contract_name = "app2-web-to-db"
    description   = "Allow all traffic from Web to DB Tier"
    tenant_name   = "demo-basic-1"    ## Tenant to add filter to
    scope         = "tenant" # "global", "tenant", "application-profile" and "context"
    filters = [
      "allow-ipv4"
    ]
  }
  rfc1918-to-web = {
    contract_name = "rfc1918-to-web"
    description   = "Allow all traffic from External RFC1918 to all App Web Tiers"
    tenant_name   = "demo-basic-1"    ## Tenant to add filter to
    scope         = "tenant" # "global", "tenant", "application-profile" and "context"
    filters = [
      "allow-ipv4"
    ]
  }
  dbadmins-to-db = {
    contract_name = "dbadmins-to-db"
    description   = "Allow all traffic from DB Admins to all App DB Tiers"
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
    l3_domain       = "LAB-N9348"
    ospf_profiles   = {
      ospf-1 = {
        description = "OSPF Peering to Lab"
        area_cost   = 1
        area_id     = "0.0.0.1"
        area_type   = "nssa"
      }
    }
    logical_profiles = {
      lprof-1 = {
        lprof_name  = "demo-l3out"
        description = "Demo L3Out Logical Profile created from Terraform"
        nodes = {
          node-1 = {
            pod = 1
            leaf_node = 101
            loopback_ip = "101.1.1.1"
          }
          node-2 = {
            pod = 1
            leaf_node = 102
            loopback_ip = "102.1.1.1"
          }
        }
        interface_profiles = {
          intprof-1 = {
            intprof_name  = "demo-l3out-intprof"
            description   = "Demo L3Out Logical Interface Profile created from Terraform"
            ospf_profiles = {
              ospf-1 = {
                description = "OSPF Interface Auth and Policy Config"
                auth_key    = "key"
                auth_key_id = 255
                auth_type   = "none"
                # ospf_policy = "default"
              }
            }
            paths = {
              path-1 = {
                description     = "Demo L3 SVI Path"
                type            = "ext-svi"
                ip              = "10.66.209.22/30"
                vlan_id         = 302
                pod             = 1
                leaf_node       = 102
                port            = "eth1/1"
              }
            }
          }
        }
      }
    }
    extepgs = {
      ### STAGE 4 - Add Contracts - Remove Preferred Group ###
      rfc1918 = {
        extepg_name         = "rfc1918"
        description         = "External users in RFC1918 subnets"
        ### STAGE 4 - Remove Preferred Group
        preferred_group     = "exclude"
        consumed_contracts = {
          cons-1 = {
            contract_name = "rfc1918-to-web"
          }
        }
        provided_contracts = {}
        contract_master_epgs = {}
        subnets = {
          N-10-0-0-0-8 = {
            description = "10.0.0.0/8"
            aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
            ip = "10.0.0.0/8"
            scope = ["import-security"]
          }
          N-172-16-0-0-12 = {
            description = "172.16.0.0/12"
            aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
            ip = "172.16.0.0/12"
            scope = ["import-security"]
          }
          N-192-168-0-0-16 = {
            description = "192.168.0.0/16"
            aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
            ip = "192.168.0.0/16"
            scope = ["import-security"]
          }
        }
      }
      ### STAGE 4 - New DB Admin Users Group, Add Contracts ###
      # dbadmins = {
      #   extepg_name         = "dbadmins"
      #   description         = "DB Admin Users"
      #   preferred_group     = "exclude"
      #   consumed_contracts = {
      #     cons-1 = {
      #       contract_name = "dbadmins-to-db"
      #     }
      #   }
      #   provided_contracts = {}
      #   contract_master_epgs = {
      #     # epg-1 = {
      #     #   l3out_name = "demo-l3out"
      #     #   epg_name= "rfc1918"
      #     # }
      #   }
      #   subnets = {
      #     H-10-67-29-4 = {
      #       description = "10.67.29.4/32"
      #       aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
      #       ip = "10.67.29.4/32"
      #       scope = ["import-security"]
      #     }
      #   }
      # }
    }
  }
}
