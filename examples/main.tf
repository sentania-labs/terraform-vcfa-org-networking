provider "vcfa" {
  url                  = var.vcfa_url
  org                  = var.vcfa_organization
  api_token            = var.vcfa_refresh_token
  allow_unverified_ssl = var.insecure
  auth_type            = "api_token"
}

module "org_networking" {
  source = "../"

  org_id              = var.org_id
  log_name            = var.log_name
  region_id           = var.region_id
  provider_gateway_id = var.provider_gateway_id
  name                = var.name
  edge_cluster_id     = var.edge_cluster_id
}
