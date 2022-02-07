### Build Tenants ###
resource "aci_tenant" "tenants" {

  for_each    = var.tenants

  name        = each.value.name
  description = each.value.description
  annotation  = "orchestrator:Terraform Cloud"
}
