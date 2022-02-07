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
  demo-basic-1 = {
    vrf_name    = "demo-vrf-1"
    description = "VRF #1 for Tenant #1 from Terraform Cloud"
    tenant_name = "demo-basic-1" ## Tenant to add VRF to
  }
  demo-basic-2 = {
    vrf_name    = "demo-vrf-2"
    description = "VRF #2 for Tenant #1 from Terraform Cloud"
    tenant_name = "demo-basic-1" ## Tenant to add VRF to
  }
}
