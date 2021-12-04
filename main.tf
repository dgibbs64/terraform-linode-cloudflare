# Linode Provider definition
terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.25.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.4.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

provider "cloudflare" {
  api_token  = var.cloudflare_token
}

resource "linode_instance" "linode-server" {
  count = length(var.server_name)
  label = "${var.server_name[count.index]}"
  image = "${var.linode_image[count.index]}"
  tags = "${var.linode_tags}"
  region = "${var.linode_region}"
  type = "${var.linode_type}"
  authorized_keys = [var.authorized_keys]
  watchdog_enabled = "true"
  #root_pass = var.root_pass
}

# Create a record
resource "cloudflare_record" "cloudflare-dns" {
  count = length(linode_instance.linode-server)
  zone_id = "${var.cloudflare_zone_id}"
  name    = "${var.server_name[count.index]}"
  value   = "${linode_instance.linode-server[count.index].ip_address}"
  type    = "A"
  proxied = false
}
resource "linode_rdns" "my_rdns" {
  count = length(linode_instance.linode-server)
  address = "${linode_instance.linode-server[count.index].ip_address}"
  rdns = "${cloudflare_record.cloudflare-dns[count.index].hostname}"
}

output "linode_ip_addr" {
  value = linode_instance.linode-server[*].ip_address
}

output "cloudflare_hostname" {
  value = cloudflare_record.cloudflare-dns[*].hostname
}