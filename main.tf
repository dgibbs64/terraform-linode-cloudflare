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
  label = "${var.server_name}"
  image = "${var.linode_image}"
  tags = "${var.linode_tags}"
  region = "${var.linode_region}"
  type = "${var.linode_type}"
  authorized_keys = [var.authorized_keys]
  #root_pass = var.root_pass
}

# Create a record
resource "cloudflare_record" "cloudflare-dns" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "${var.server_name}"
  value   = "${linode_instance.linode-server.ip_address}"
  type    = "A"
  proxied = false
}

output "instance_ip_addr" {
  value = linode_instance.linode-server.ip_address
}