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
  demo-vrf-1 = {
    vrf_name    = "demo-vrf-1"
    description = "VRF #1 for Tenant #1"
    tenant_name = "demo-basic-1" ## Tenant to add VRF to
  }
  demo-vrf-2 = {
    vrf_name    = "demo-vrf-2"
    description = "VRF #2 for Tenant #1"
    tenant_name = "demo-basic-1" ## Tenant to add VRF to
  }
}

### Bridge Domains & L3 Subnets ###
bds = {
  demo-bd-1 = {
    bd_name     = "demo-bd-1"
    vrf_name    = "demo-vrf-1"      ## VRF to add BD to
    description = "Demo Bridge Domain #1 for Tenant #1"
    tenant_name = "demo-basic-1"    ## Tenant to add VRF to
    subnets = {
      sub1 = {
        name        = "Primary Subnet"
        ip          = "192.168.1.1/24"
        description = "Primary Subnet for BD#1"
        scope       = ["public"]
        preferred   = "yes"
      },
      sub2 = {
        name        = "Secondary Subnet"
        ip          = "192.168.101.1/24"
        description = "Secondary Subnet for BD#1"
        scope       = ["public"]
        preferred   = "no"
      }

    }
  }
  demo-bd-2 = {
    bd_name     = "demo-bd-2"
    vrf_name    = "demo-vrf-1"      ## VRF to add BD to
    description = "Demo Bridge Domain #2 for Tenant #1"
    tenant_name = "demo-basic-1"    ## Tenant to add VRF to
    subnets     = {}
  }
}

### Application Profiles & End Point Groups ###
aps = {
  demo-ap-1 = {
    ap_name = "demo-ap-1"
    tenant_name = "demo-basic-1"    ## Tenant to add AP to
    description = "App Profile #1 for Tenant #1"
    epgs = {
      epg1 = {
        epg_name = "demo-epg-1"
        bd_name = "demo-bd-1"       ## Bridge Domain to add EPG to
        description = "Demo EPG #1 in BD #1"
      }
      epg2 = {
        epg_name = "demo-epg-2"
        bd_name = "demo-bd-1"       ## Bridge Domain to add EPG to
        description = "Demo EPG #2 in BD #1"
      }
    }
  }
}
