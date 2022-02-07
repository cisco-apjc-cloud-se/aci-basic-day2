### Tennant Input Variable Object ###

variable "tenants" {
  type = map(object({
    name        = string
    description = string
  }))
}
