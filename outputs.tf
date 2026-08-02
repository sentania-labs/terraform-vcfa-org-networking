output "org_networking_id" {
  description = "ID of the vcfa_org_networking resource"
  value       = vcfa_org_networking.this.id
}

output "networking_tenancy_enabled" {
  description = "Whether the Organization has tenancy for the network domain in the backing network provider"
  value       = vcfa_org_networking.this.networking_tenancy_enabled
}

output "org_regional_networking_id" {
  description = "ID of the vcfa_org_regional_networking resource"
  value       = vcfa_org_regional_networking.regional.id
}

output "name" {
  description = "Name of the Org Regional Networking object; likely the value downstream SupervisorNamespaces reference as vpc_name, but this is unverified against a live VCFA org and should be confirmed before wiring it through"
  value       = vcfa_org_regional_networking.regional.name
}

output "status" {
  description = "Status of Org Regional Networking"
  value       = vcfa_org_regional_networking.regional.status
}

output "edge_cluster_id" {
  description = "Backing Edge Cluster ID for Org Regional Networking (autoselected value if not supplied)"
  value       = vcfa_org_regional_networking.regional.edge_cluster_id
}

output "region_id" {
  description = "ID of the Region the Org Regional Networking belongs to"
  value       = vcfa_org_regional_networking.regional.region_id
}
