# ### Existing VMM Domain Name ###
# vmm_name = "DVS-VMM"
#
# ### Existing Physical Domain Name ###
# phys_name = "LAB-N9348"

### Tenants ###
tenants = {
  common = {
    name = "common"
    existing = true
  }
  demo-basic-1 = {
    name        = "demo-basic-1"
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
    ### STAGE 2 - Enable Preferred Group on VRF
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
    ### STAGE 2 - ARP Flood No Longer Required, Set BD vMAC to HSRP MAC & Map to L3Out
    arp_flood   = "no" ## "yes", "no"
    mac_address = "00:00:0C:9F:F1:2F"  ## HSRP v2 MAC!
    l3outs      = ["demo-l3out"] ## List of associated L3outs for BD's Subnets
    subnets = {
      ### STAGE 2 - Move Gateway to Bridge Domain
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
    ### STAGE 2 - ARP Flood No Longer Required, Set BD vMAC to HSRP MAC & Map to L3Out
    arp_flood   = "no" ## "yes", "no"
    mac_address = "00:00:0C:9F:F1:30"  ## HSRP v2 MAC!
    l3outs      = ["demo-l3out"] ## List of associated L3outs for BD's Subnets
    subnets = {
      ### STAGE 2 - Move Gateway to Bridge Domain
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
  legacy = {
    ap_name = "legacy"
    tenant_name = "demo-basic-1"    ## Tenant to add AP to
    description = "App Profile for Legacy Network Centric VLANs"
    ### STAGE 2 - Enable ESGs - one per EPG
    esgs = {
      legacy-esg = {
        esg_name        = "legacy-esg"
        description     = "Legacy Networks ESG"
        ### STAGE 2 - Enabled Preferred Group
        preferred_group = "include"
        vrf_name        = "vrf-1"
        consumed_contracts = {}
        provided_contracts = {}
      }
    }
    epgs = {
      vl-303 = {
        epg_name = "vl-303"
        bd_name = "bd-303"       ## Bridge Domain to add EPG to
        description = "EPG for VLAN 303"
        # vmm_enabled = true
        domains = {
          vmm = {
            name = "DVS-VMM"
            type = "vmware"
          }
          phys = {
            name = "LAB-N9348"
            type = "physical"
          }
        }
        ### STAGE 2 - Map EPG to ESG
        mapped_esg = "legacy-esg" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG!
        paths = {
          ### STAGE 2 - Static EPG to Upstream Switch No Longer Required

          # path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
          #   pod       = 1
          #   leaf_node = 101
          #   port      = "eth1/1"
          #   vlan_id   = 333
          #   mode      = "regular" # regular, native, untagged
          # }
          # path2 = { # topology/pod-1/paths-101/pathep-[eth1/23]
          #   pod       = 1
          #   leaf_node = 102
          #   port      = "eth1/1"
          #   vlan_id   = 303
          #   mode      = "regular" # regular, native, untagged
          # }
        }
      }
      vl-304 = {
        epg_name = "vl-304"
        bd_name = "bd-304"       ## Bridge Domain to add EPG to
        description = "EPG for VLAN 304"
        # vmm_enabled = true
        domains = {
          vmm = {
            name = "DVS-VMM"
            type = "vmware"
          }
          phys = {
            name = "LAB-N9348"
            type = "physical"
          }
        }
        ### STAGE 2 - Map EPG to ESG
        mapped_esg = "legacy-esg" # "esg-1"
        preferred_group = "include"  ## Must be the same as ESG!
        paths = {
          ### STAGE 2 - Static EPG to Upstream Switch No Longer Required

          # path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
          #   pod       = 1
          #   leaf_node = 101
          #   port      = "eth1/1"
          #   vlan_id   = 333
          #   mode      = "regular" # regular, native, untagged
          # }
          # path2 = { # topology/pod-1/paths-101/pathep-[eth1/23]
          #   pod       = 1
          #   leaf_node = 102
          #   port      = "eth1/1"
          #   vlan_id   = 304
          #   mode      = "regular" # regular, native, untagged
          # }
        }
      }
    }
  }
}

### Filters ###
filters = {}


### Contracts ###
contracts = {}

### L3Outs & External EPGs ###
l3outs = {
  ### STAGE 2 - Enable L3Out with OSPF & External EPG (RFC1918)
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
                ospf_policy = {}
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
      rfc1918 = {
        extepg_name         = "rfc1918"
        description         = "External users in RFC1918 subnets"
        preferred_group     = "include"
        consumed_contracts = {}
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
    }
  }
}
