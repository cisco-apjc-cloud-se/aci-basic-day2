### Tenant Model ###
tenants = {
  ### Tenants ###
  common = {
    name = "common"
    use_existing = true
    aps = {}
    networking = {
      vrfs = {}
      bds = {}
      l3outs = {}
    }
    contracts = {
      standard = {}
      filters = {}
    }
  }
  demo-basic-1 = {
    name          = "demo-basic-1"
    use_existing  = false
    description   = "Basic ACI Tenant #1 built from Terraform Cloud"
    ### Application Profiles & End Point Groups ###
    aps = {
      legacy = {
        ap_name = "legacy"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Legacy Network Centric VLANs"
        ### STAGE 2 - Enable ESGs
        esgs = {
          legacy-esg = {
            esg_name        = "legacy-esg"
            description     = "Legacy Networks ESG"
            ### STAGE 2 - Enabled Preferred Group
            preferred_group = "include"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {}
            provided_contracts = {}
          }
        }
        epgs = {
          vl-303 = {
            epg_name = "vl-303"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
            description = "EPG for VLAN 303"
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
            mapped_esg = {
              esg_name = "legacy-esg"
            }
            ### STAGE 2 - Enabled Preferred Group
            preferred_group = "include"
            paths = {
              ### STAGE 2 - Static EPG to Upstream Switch No Longer Required

              # # path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
              # #   pod       = 1
              # #   leaf_node = 101
              # #   port      = "eth1/1"
              # #   vlan_id   = 333
              # #   mode      = "regular" # regular, native, untagged
              # # }
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
            bd = {
              bd_name = "bd-304"       ## Bridge Domain to add EPG to
            }
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
            mapped_esg = {
              esg_name = "legacy-esg"
            }
            ### STAGE 2 - Enabled Preferred Group
            preferred_group = "include"
            paths = {
              ### STAGE 2 - Static EPG to Upstream Switch No Longer Required

              # # path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
              # #   pod       = 1
              # #   leaf_node = 101
              # #   port      = "eth1/1"
              # #   vlan_id   = 333
              # #   mode      = "regular" # regular, native, untagged
              # # }
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
    networking = {
      ### VRFs ###
      vrfs = {
        vrf-1 = {
          vrf_name    = "vrf-1"
          description = "VRF #1 for Tenant #1"
          ### STAGE 2 - Enable Preferred Group on VRF
          preferred_group = "enabled"
        }
      }
      ### Bridge Domains & L3 Subnets ###
      bds = {
        bd-303 = {
          bd_name     = "bd-303"
          vrf = {
            vrf_name    = "vrf-1"      ## VRF to add BD to
          }
          description = " Bridge Domain for Legacy VLAN 303 in Tenant #1"
          mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
          ### STAGE 2 - ARP Flood No Longer Required, Set BD vMAC to HSRP MAC & Map to L3Out
          arp_flood   = "no" ## "yes", "no"
          l3outs      = [] ## List of associated L3outs for BD's Subnets
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
          vrf = {
            vrf_name    = "vrf-1"      ## VRF to add BD to
          }
          description = " Bridge Domain for Legacy VLAN 304 in Tenant #1"
          mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
          ### STAGE 2 - ARP Flood No Longer Required, Set BD vMAC to HSRP MAC & Map to L3Out
          arp_flood   = "no" ## "yes", "no"
          l3outs      = [] ## List of associated L3outs for BD's Subnets
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
        # bd-305 = {
        #   bd_name     = "bd-305"
        #   vrf_name    = "vrf-1"      ## VRF to add BD to
        #   description = " Bridge Domain for Legacy VLAN 305 in Tenant #1"
        #   tenant_name = "demo-basic-1"    ## Tenant to add VRF to
        #   mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
        #   arp_flood   = "yes" ## "yes", "no"
        #   l3outs      = [] ## List of associated L3outs for BD's Subnets
        #   subnets = {}
        # }
      }
      ### Layer3 Outs and External EPGs ###
      l3outs = {}
    }
    contracts = {
      standard = {}
      filters = {}
    }
  }
  demo-basic-2 = {
    name = "demo-basic-2"
    use_existing = false
    description = "Basic ACI Tenant #2 built from Terraform Cloud"
    aps = {}
    networking = {
      vrfs = {}
      bds = {}
      l3outs = {}
    }
    contracts = {
      standard = {}
      filters = {}
    }
  }
}
