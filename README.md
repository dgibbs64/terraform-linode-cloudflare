# Terraform Linode Cloudflare

![terraform-linode-cloudflare](https://user-images.githubusercontent.com/4478206/144746465-3da65f8f-d522-4136-b8de-b44705f09752.png)

## Description

Using Terraform, this configuration will allow you to spin up multiple Linode instances, create Cloudflare A records for the Linode instances and apply rDNS to the Linode instances.

## Requirements

- [Linode Account](https://linode.com)
- [Cloudflare Account](https://www.cloudflare.com/)
- Domain name
- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Authentication

Multiple tokens will be required to authenticate terraform with Linode and Cloudflare.

- [Linode API Token](https://www.linode.com/docs/guides/getting-started-with-the-linode-api/)
- [Cloudflare API Token](https://developers.cloudflare.com/api/tokens/create)
- [Cloudflare Zone ID](https://community.cloudflare.com/t/where-to-find-zone-id/132913)
- [SSH Public Key](https://www.linode.com/docs/guides/use-public-key-authentication-with-ssh) (reccomended)
- root Password (optional)

> note: This example uses SSH keys only. To use root password uncomment in `main.tf`, `variables.tf` and `terraform.tvars`.

## Single Linode Instance

This example `terraform.tfvars` will deploy a single Linode instance.

```terraform
server_name = "ubuntu20.04"
#root_pass = ""
authorized_keys = "ecdsa-sha2-nistp256 AAAAE2...rTucc= dgibbs@home"
linode_token = "--- Linode API Token ---"
linode_image = "linode/ubuntu20.04"
linode_region = "eu-west"
linode_type = "g6-nanode-1"
linode_tags = [ "Tag 1", "Tag 2" ]
cloudflare_token = "--- Cloudflare API Token ---"
cloudflare_zone_id = "--- Cloudflare Zone ID ---"
```

## Multiple Linode Instance

This example `terraform.tfvars` will deploy multiple Linode instances.

This example will create 5 Linode instances using difference distro images. It does this by using arrays and will loop though each`server_name`. It is also possible using the same arrays to specify different _regions_ and _types_ by adding `[count.index]` in `main.tf`.

```terraform
server_name = [ "ubuntu20.04", "ubuntu18.04", "debian11", "almalinux8", "centos7" ]
#root_pass = ""
authorized_keys = "ecdsa-sha2-nistp256 AAAAE2...rTucc= dgibbs@home"
linode_token = "--- Linode API Token ---"
linode_image = [ "linode/ubuntu20.04", "linode/ubuntu18.04", "linode/debian11", "linode/almalinux8", "linode/centos7" ]
linode_region = "eu-west"
linode_type = "g6-nanode-1"
linode_tags = [ "Tag 1", "Tag 2" ]
cloudflare_token = "--- Cloudflare API Token ---"
cloudflare_zone_id = "--- Cloudflare Zone ID ---"
```
