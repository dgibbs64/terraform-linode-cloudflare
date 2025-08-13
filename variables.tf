variable "server_name" {
  description = "List of server names for Linode instances"
  type        = list(string)
}

variable "authorized_keys" {
  description = "SSH public keys for server access"
  type        = string
}

variable "linode_token" {
  description = "API token for Linode provider"
  type        = string
  sensitive   = true
}

variable "linode_image" {
  description = "List of Linode image IDs"
  type        = list(string)
}

variable "linode_region" {
  description = "Linode region to deploy instances"
  type        = string
}

variable "linode_type" {
  description = "Linode instance type"
  type        = string
}

variable "linode_tags" {
  description = "Tags to assign to Linode instances"
  type        = list(string)
  default     = []
}

# variable "linode_root_pass" {
#   description = "Root password for Linode instances"
#   type        = string
#   sensitive   = true
# }

variable "cloudflare_token" {
  description = "API token for Cloudflare provider"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}
