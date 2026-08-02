resource "vcfa_org_networking" "this" {
  org_id   = var.org_id
  log_name = var.log_name
}

# org_id is read back off vcfa_org_networking.this rather than var.org_id
# directly so Terraform's dependency graph forces this resource to wait for
# Organization Networking to finish provisioning first. See README for why.
resource "vcfa_org_regional_networking" "regional" {
  name                = var.name
  org_id              = vcfa_org_networking.this.org_id
  region_id           = var.region_id
  provider_gateway_id = var.provider_gateway_id
  edge_cluster_id     = var.edge_cluster_id
}
