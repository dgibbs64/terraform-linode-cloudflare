# Linode Provider definition
terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.22.0"
    }
  }
}

provider "linode" {
  token = var.token
}

# Example Web Server
resource "linode_instance" "terraform-web" {
        image = "linode/centos7"
        label = "Terraform-Web-Example"
        group = "Terraform"
        region = var.region
        type = "g6-standard-1"
        swap_size = 1024
        authorized_keys = [var.authorized_keys]
        root_pass = var.root_pass
}

# Example Database Server
resource "linode_instance" "terraform-db" {
        image = "linode/ubuntu18.04"
        label = "Terraform-Db-Example"
        group = "Terraform"
        region = var.region
        type = "g6-standard-1"
        swap_size = 1024
        authorized_keys = [var.authorized_keys]
        root_pass = var.root_pass
}