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
      std_contracts = {}
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
        esgs = {}
        epgs = {
          vl-303 = {
            epg_name = "vl-303"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
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
            mapped_esg = {}
            preferred_group = "exclude"
            paths = {
              # path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
              #   pod       = 1
              #   leaf_node = 101
              #   port      = "eth1/1"
              #   vlan_id   = 333
              #   mode      = "regular" # regular, native, untagged
              # }
              path2 = { # topology/pod-1/paths-101/pathep-[eth1/23]
                pod       = 1
                leaf_node = 102
                port      = "eth1/1"
                vlan_id   = 303
                mode      = "regular" # regular, native, untagged
              }
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
            mapped_esg = {}
            preferred_group = "exclude"
            paths = {
              # path1 = { # topology/pod-1/paths-101/pathep-[eth1/23]
              #   pod       = 1
              #   leaf_node = 101
              #   port      = "eth1/1"
              #   vlan_id   = 333
              #   mode      = "regular" # regular, native, untagged
              # }
              path2 = { # topology/pod-1/paths-101/pathep-[eth1/23]
                pod       = 1
                leaf_node = 102
                port      = "eth1/1"
                vlan_id   = 304
                mode      = "regular" # regular, native, untagged
              }
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
          preferred_group = "disabled"
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
          arp_flood   = "yes" ## "yes", "no"
          l3outs      = [] ## List of associated L3outs for BD's Subnets
          subnets = {}
        }
        bd-304 = {
          bd_name     = "bd-304"
          vrf = {
            vrf_name    = "vrf-1"      ## VRF to add BD to
          }
          description = " Bridge Domain for Legacy VLAN 304 in Tenant #1"
          mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
          arp_flood   = "yes" ## "yes", "no"
          l3outs      = [] ## List of associated L3outs for BD's Subnets
          subnets = {}
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
      std_contracts = {}
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
      std_contracts = {}
      filters = {}
    }
  }
}
