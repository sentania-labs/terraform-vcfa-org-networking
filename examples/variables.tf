variable "org_id" {
  type        = string
  description = "ID of the parent Organization"
}

variable "log_name" {
  type        = string
  description = "Globally unique identifier (max 8 characters) for this Organization in the logs of the backing network provider"
}

variable "region_id" {
  type        = string
  description = "ID of the Region"
}

variable "provider_gateway_id" {
  type        = string
  description = "ID of the parent Provider Gateway"
}

variable "name" {
  type        = string
  description = "Name of the Org Regional Networking object"
}

variable "edge_cluster_id" {
  type        = string
  description = "Backing Edge Cluster ID; leave null to let VCFA autoselect"
  default     = null
}

########################################
# General VCF-A Configuration
########################################

/**
 * vcfa_url
 * URL of the VCF-A (Aria Automation) endpoint.
 */
variable "vcfa_url" {
  type = string
}

variable "vcfa_organization" {
  type        = string
  description = "The VCFA Organization"
}

/**
 * vcfa_refresh_token
 * Refresh token used for authentication to the VCF-A API.
 * Marked sensitive to avoid logging/output exposure.
 */
variable "vcfa_refresh_token" {
  type      = string
  sensitive = true
}

/**
 * insecure
 * Whether to skip SSL certificate verification when connecting
 * to the VCF-A API (typically true for lab environments).
 */
variable "insecure" {
  type    = bool
  default = true
}
