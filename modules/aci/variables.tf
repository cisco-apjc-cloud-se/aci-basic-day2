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
      name          = string
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
      }))
  }))
}
