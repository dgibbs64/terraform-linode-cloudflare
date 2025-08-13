# Example Terraform Module

## Description

This repository provides a Terraform configuration to deploy a virtual machine for ingesting scanner output. The VM enables scanners to securely upload documents via SFTP, and uses rclone to transfer those documents to a cloud storage service. The deployment leverages a Linode VM and configures Cloudflare DNS.

## Prerequisites

- [Linode Account](https://linode.com)
- [Cloudflare Account](https://www.cloudflare.com/)
- Domain name
- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [List of current images](https://api.linode.com/v4/images)
- [List of current instance types](https://api.linode.com/v4/linode/types)

## Authentication

Multiple tokens will be required to authenticate terraform with Linode and Cloudflare.

- [Linode API Token](https://www.linode.com/docs/guides/getting-started-with-the-linode-api/)
- [Cloudflare API Token](https://developers.cloudflare.com/api/tokens/create)
- [Cloudflare Zone ID](https://community.cloudflare.com/t/where-to-find-zone-id/132913)
- [SSH Public Key](https://www.linode.com/docs/guides/use-public-key-authentication-with-ssh) (reccomended)
- root Password (optional)

---

<!-- prettier-ignore-start -->
<!-- textlint-disable -->
<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                        | Version   |
| --------------------------------------------------------------------------- | --------- |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement_cloudflare) | ~> 5.7.1  |
| <a name="requirement_linode"></a> [linode](#requirement_linode)             | ~> 3.1.1  |
| <a name="requirement_time"></a> [time](#requirement_time)                   | ~> 0.13.1 |

## Providers

| Name                                                                  | Version   |
| --------------------------------------------------------------------- | --------- |
| <a name="provider_cloudflare"></a> [cloudflare](#provider_cloudflare) | ~> 5.7.1  |
| <a name="provider_linode"></a> [linode](#provider_linode)             | ~> 3.1.1  |
| <a name="provider_time"></a> [time](#provider_time)                   | ~> 0.13.1 |

## Modules

No modules.

## Resources

| Name                                                                                                                                   | Type     |
| -------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [cloudflare_dns_record.cloudflare-dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [linode_instance.linode-server](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance)                  | resource |
| [linode_rdns.my_rdns](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/rdns)                                | resource |
| [time_sleep.wait_300_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep)                      | resource |

## Inputs

| Name                                                                                    | Description                               | Type           | Default | Required |
| --------------------------------------------------------------------------------------- | ----------------------------------------- | -------------- | ------- | :------: |
| <a name="input_authorized_keys"></a> [authorized_keys](#input_authorized_keys)          | SSH public keys for server access         | `string`       | n/a     |   yes    |
| <a name="input_cloudflare_token"></a> [cloudflare_token](#input_cloudflare_token)       | API token for Cloudflare provider         | `string`       | n/a     |   yes    |
| <a name="input_cloudflare_zone_id"></a> [cloudflare_zone_id](#input_cloudflare_zone_id) | Cloudflare Zone ID                        | `string`       | n/a     |   yes    |
| <a name="input_linode_image"></a> [linode_image](#input_linode_image)                   | List of Linode image IDs                  | `list(string)` | n/a     |   yes    |
| <a name="input_linode_region"></a> [linode_region](#input_linode_region)                | Linode region to deploy instances         | `string`       | n/a     |   yes    |
| <a name="input_linode_tags"></a> [linode_tags](#input_linode_tags)                      | Tags to assign to Linode instances        | `list(string)` | `[]`    |    no    |
| <a name="input_linode_token"></a> [linode_token](#input_linode_token)                   | API token for Linode provider             | `string`       | n/a     |   yes    |
| <a name="input_linode_type"></a> [linode_type](#input_linode_type)                      | Linode instance type                      | `string`       | n/a     |   yes    |
| <a name="input_server_name"></a> [server_name](#input_server_name)                      | List of server names for Linode instances | `list(string)` | n/a     |   yes    |

## Outputs

| Name                                                                                         | Description                                  |
| -------------------------------------------------------------------------------------------- | -------------------------------------------- |
| <a name="output_cloudflare_hostname"></a> [cloudflare_hostname](#output_cloudflare_hostname) | Hostnames managed by Cloudflare DNS          |
| <a name="output_linode_ip_addr"></a> [linode_ip_addr](#output_linode_ip_addr)                | IP addresses of the created Linode instances |

<!-- END_TF_DOCS -->
<!-- textlint-enable -->
<!-- prettier-ignore-end -->
