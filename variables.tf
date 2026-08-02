variable "org_id" {
  type        = string
  description = "ID of the parent Organization to enable Organization Networking for"
}

variable "log_name" {
  type        = string
  description = "Globally unique identifier (max 8 characters) for this Organization in the logs of the backing network provider"

  validation {
    condition     = length(var.log_name) > 0 && length(var.log_name) <= 8
    error_message = "log_name must be between 1 and 8 characters."
  }
}

variable "region_id" {
  type        = string
  description = "ID of the Region the Org Regional Networking belongs to"
}

variable "provider_gateway_id" {
  type        = string
  description = "ID of the parent Provider Gateway for Org Regional Networking"
}

variable "name" {
  type        = string
  description = "Name of the Org Regional Networking object"
}

variable "edge_cluster_id" {
  type        = string
  description = "Backing Edge Cluster ID for Org Regional Networking. Autoselected by VCFA when left null"
  default     = null
}
