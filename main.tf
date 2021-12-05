# Linode Provider definition
terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "~> 1.25.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.4.0"
    }
    time = {
      source = "hashicorp/time"
      version = "~> 0.7.2"
    }
  }
}

provider "time" {
}

provider "linode" {
  token = var.linode_token
}

provider "cloudflare" {
  api_token  = var.cloudflare_token
}

# Ensure Linodes Instances Exist.
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

# Ensure Cloudflare A Record Exists.
# 60 Second ttl setup to allow rDNS to work
resource "cloudflare_record" "cloudflare-dns" {
  count = length(linode_instance.linode-server)
  zone_id = "${var.cloudflare_zone_id}"
  name    = "${var.server_name[count.index]}"
  value   = "${linode_instance.linode-server[count.index].ip_address}"
  type    = "A"
  proxied = false
  ttl     = 60
}

# Wait 60 Seconds to allow A Record to update.
resource "time_sleep" "wait_60_seconds" {
  depends_on = [cloudflare_record.cloudflare-dns]
  create_duration = "60s"
}

# Ensure Linode Instance rDNS exists.
# rDNS has to check existing A record exists and matches
resource "linode_rdns" "my_rdns" {
  depends_on = [time_sleep.wait_60_seconds]
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