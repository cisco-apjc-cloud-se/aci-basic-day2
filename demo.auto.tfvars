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
  # vrf-2 = {
  #   vrf_name    = "vrf-2"
  #   description = "VRF #2 for Tenant #1"
  #   tenant_name = "demo-basic-1" ## Tenant to add VRF to
  # }
  # vrf-3 = {
  #   vrf_name    = "vrf-3"
  #   description = "VRF #3 for Tenant #1"
  #   tenant_name = "demo-basic-1" ## Tenant to add VRF to
  # }
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
      }
      # sub-2 = {
      #   ip          = "192.168.101.1/24"
      #   description = "Secondary Subnet for BD#1"
      #   scope       = ["public"]
      #   preferred   = "no"
      # }
    }
  }
  # bd-2 = {
  #   bd_name     = "bd-2"
  #   vrf_name    = "vrf-1"      ## VRF to add BD to
  #   description = "Demo Bridge Domain #2 for Tenant #1"
  #   tenant_name = "demo-basic-1"    ## Tenant to add VRF to
  #   subnets     = {}
  # }
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
            port      = "eth1/10"
            vlan_id   = 333
            mode      = "regular" # regular, native, untagged
          }
          path2 = { # topology/pod-1/paths-101/pathep-[eth1/23]
            pod       = 1
            leaf_node = 102
            port      = "eth1/10"
            vlan_id   = 333
            mode      = "regular" # regular, native, untagged
          }
        }
      }
      # epg-2 = {
      #   epg_name = "epg-2"
      #   bd_name = "bd-1"       ## Bridge Domain to add EPG to
      #   description = "Demo EPG #2 in BD #1"
      #   vmm_enabled = true
      #   paths = {}
      # }
    }
  }
}

### Filters ###
filters = {}


### Contracts ###
contracts = {}

### L3Outs & External EPGs ###
l3outs = {}
