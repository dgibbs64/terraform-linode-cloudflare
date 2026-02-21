# Linode Provider definition
terraform {
  required_version = ">= 1.5.0, < 2.0.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 3.8.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.7.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.1"
    }
  }
}

provider "time" {}

provider "linode" {
  token = var.linode_token
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}
