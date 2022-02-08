### Existing ACI Virtual Machine Manager (VMM) Domain ###
variable "vmm_name" {
  type = string
}

### Tennant Input Variable Object ###

variable "tenants" {
  type = map(object({
    name        = string
    description = string
  }))
}

### VRF Input Variable Object ###

variable "vrfs" {
  type = map(object({
    vrf_name      = string
    description   = string
    tenant_name   = string
  }))
}

### Bridge Domain Input Variable Object ###

variable "bds" {
  type = map(object({
    bd_name       = string
    vrf_name      = string
    description   = string
    tenant_name   = string
    subnets = map(object({
      description   = string
      ip            = string
      scope         = list(string)
      preferred     = string
      }))
  }))
}

### Application Profile Input Variable Object ###

variable "aps" {
  type = map(object({
    ap_name     = string
    tenant_name = string
    description = string
    epgs = map(object({
      epg_name  = string
      bd_name   = string
      description = string
      vmm_enabled = bool
      paths = map(object({
        pod       = number
        leaf_node = number
        port      = string
        vlan_id   = number
        mode      = string
        }))
      }))
  }))
}

### Filter Input Variable Object ###

variable "filters" {
  type = map(object({
    filter_name = string
    tenant_name = string
    description = string
    entries = map(object({
      name        = string
      description = string
      ether_t     = string
      d_from_port = string
      d_to_port   = string
      prot        = string
      s_from_port = string
      s_to_port   = string
      }))
  }))
}
