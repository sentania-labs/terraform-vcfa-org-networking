# terraform-vcfa-org-networking

Terraform module — wraps `vcfa_org_networking` and `vcfa_org_regional_networking` from the `vmware/vcfa` provider. This is the unit that turns on network tenancy for an Organization and mints its regional networking object (the thing downstream `SupervisorNamespace`s attach to). Without it an org has no VPCs, no transit gateways, and no connectivity profiles, and namespace creation fails.

## The trap this module hides

`vcfa_org_regional_networking` and `vcfa_org_networking` both take an `org_id` argument, so it is easy to write both resources pointing at the same `var.org_id` and assume that's fine, since the value is identical either way.

It is not fine. The VCFA API needs Organization Networking (`vcfa_org_networking`, which sets `log_name`) to finish provisioning *before* Org Regional Networking is created. Terraform only serializes two resources when there is an actual reference between them in the configuration. If both resources read `org_id` straight from the input variable, there is nothing in the dependency graph forcing that order, Terraform is free to create them concurrently, and the regional networking object can come up against an org whose networking log name was never set. There is no error: the apply reports success and the object is silently incomplete.

This module avoids that by having `vcfa_org_regional_networking` read its `org_id` off `vcfa_org_networking.this.org_id` (main.tf) rather than off `var.org_id` directly. The value is the same, but the reference gives Terraform the dependency edge it needs to apply `vcfa_org_networking` first. Callers of this module never have to know this rule exists.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.0 |
| <a name="requirement_vcfa"></a> [vcfa](#requirement\_vcfa) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vcfa"></a> [vcfa](#provider\_vcfa) | 1.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vcfa_org_networking.this](https://registry.terraform.io/providers/vmware/vcfa/latest/docs/resources/org_networking) | resource |
| [vcfa_org_regional_networking.regional](https://registry.terraform.io/providers/vmware/vcfa/latest/docs/resources/org_regional_networking) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_edge_cluster_id"></a> [edge\_cluster\_id](#input\_edge\_cluster\_id) | Backing Edge Cluster ID for Org Regional Networking. Autoselected by VCFA when left null | `string` | `null` | no |
| <a name="input_log_name"></a> [log\_name](#input\_log\_name) | Globally unique identifier (max 8 characters) for this Organization in the logs of the backing network provider | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the Org Regional Networking object | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | ID of the parent Organization to enable Organization Networking for | `string` | n/a | yes |
| <a name="input_provider_gateway_id"></a> [provider\_gateway\_id](#input\_provider\_gateway\_id) | ID of the parent Provider Gateway for Org Regional Networking | `string` | n/a | yes |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | ID of the Region the Org Regional Networking belongs to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_edge_cluster_id"></a> [edge\_cluster\_id](#output\_edge\_cluster\_id) | Backing Edge Cluster ID for Org Regional Networking (autoselected value if not supplied) |
| <a name="output_name"></a> [name](#output\_name) | Name of the Org Regional Networking object; likely the value downstream SupervisorNamespaces reference as vpc\_name, but this is unverified against a live VCFA org and should be confirmed before wiring it through |
| <a name="output_networking_tenancy_enabled"></a> [networking\_tenancy\_enabled](#output\_networking\_tenancy\_enabled) | Whether the Organization has tenancy for the network domain in the backing network provider |
| <a name="output_org_networking_id"></a> [org\_networking\_id](#output\_org\_networking\_id) | ID of the vcfa\_org\_networking resource |
| <a name="output_org_regional_networking_id"></a> [org\_regional\_networking\_id](#output\_org\_regional\_networking\_id) | ID of the vcfa\_org\_regional\_networking resource |
| <a name="output_region_id"></a> [region\_id](#output\_region\_id) | ID of the Region the Org Regional Networking belongs to |
| <a name="output_status"></a> [status](#output\_status) | Status of Org Regional Networking |
<!-- END_TF_DOCS -->
