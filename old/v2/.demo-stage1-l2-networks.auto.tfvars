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
    existing    = false
    description = "Basic ACI Tenant #1 built from Terraform Cloud"
  }
  demo-basic-2 = {
    name = "demo-basic-2"
    existing    = false
    description = "Basic ACI Tenant #2 built from Terraform Cloud"
  }
}

### VRFs ###
vrfs = {
  vrf-1 = {
    vrf_name    = "vrf-1"
    description = "VRF #1 for Tenant #1"
    tenant_name = "demo-basic-1" ## Tenant to add VRF to
    preferred_group = "disabled"
  }
}

### Bridge Domains & L3 Subnets ###
bds = {
  bd-303 = {
    bd_name     = "bd-303"
    vrf_name    = "vrf-1"      ## VRF to add BD to
    description = " Bridge Domain for Legacy VLAN 303 in Tenant #1"
    tenant_name = "demo-basic-1"    ## Tenant to add VRF to
    mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
    arp_flood   = "yes" ## "yes", "no"
    l3outs      = [] ## List of associated L3outs for BD's Subnets
    subnets = {}
  }
  bd-304 = {
    bd_name     = "bd-304"
    vrf_name    = "vrf-1"      ## VRF to add BD to
    description = " Bridge Domain for Legacy VLAN 304 in Tenant #1"
    tenant_name = "demo-basic-1"    ## Tenant to add VRF to
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
        mapped_esg = ""
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
        mapped_esg = ""
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

### Filters ###
filters = {}


### Contracts ###
contracts = {}

### L3Outs & External EPGs ###
l3outs = {}
