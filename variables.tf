variable "aci_user" {
  default = "admin"
}

variable "aci_password" {
  default = "C!sco123"
}

variable "aci_url" {
  default = "https://10.67.16.238"
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
