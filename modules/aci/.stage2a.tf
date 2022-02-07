/*
*   Stage 2a Configuration
*/


### Application Profile
resource "aci_application_profile" "tf-app1" {
  tenant_dn   = aci_tenant.tf-demo.id
  name        = "tf-app1"
  description = "Migrated Application #1"
}

resource "aci_application_profile" "tf-app2" {
  tenant_dn   = aci_tenant.tf-demo.id
  name        = "tf-app2"
  description = "Migrated Application #2"
}
