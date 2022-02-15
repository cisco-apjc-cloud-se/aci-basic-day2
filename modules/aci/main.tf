terraform {
  // experiments = [module_variable_optional_attrs]
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      # version = "~> 0.5.1"
    }
  }
}

## Common Data Sources

### Load VMware VMM Domain
data "aci_vmm_domain" "vmm" {
	provider_profile_dn = "uni/vmmp-VMware"
	name                = var.vmm_name #"DVS-VMM"
}

### Load Physical Domain
data "aci_physical_domain" "phys" {
  name  = var.phys_name
}
