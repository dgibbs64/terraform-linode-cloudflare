output "linode_ip_addr" {
  description = "IP addresses of the created Linode instances"
  value       = linode_instance.linode-server[*].ip_address
}

output "cloudflare_hostname" {
  description = "Hostnames managed by Cloudflare DNS"
  value       = cloudflare_dns_record.cloudflare-dns[*].name
}
