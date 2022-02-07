### ACI Credentials & Users - from TFC Variable Set ###
variable "aci_user" {
}

variable "aci_password" {
}

variable "aci_url" {
}

// variable "vsphere_user" {
//   default = "administrator@lab16demo.cisco.com"
// }
//
// variable "vsphere_password" {
//   default = "C!sco123"
// }
//
// variable "vsphere_server" {
//   default = "10.67.16.179"
// }


### Tennant Input Variable Object ###

variable "tenants" {
  type = map(object({
    name        = string
    description = string
  }))
}

###
