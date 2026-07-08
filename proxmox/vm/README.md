<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.77 |
| <a name="requirement_tailscale"></a> [tailscale](#requirement\_tailscale) | ~> 0.17 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | ~> 0.77 |
| <a name="provider_tailscale"></a> [tailscale](#provider\_tailscale) | ~> 0.17 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_file.cloud_init_user_data](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.vm](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |
| [tailscale_tailnet_key.auth_key](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/tailnet_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_init_packages"></a> [cloud\_init\_packages](#input\_cloud\_init\_packages) | n/a | `list(string)` | <pre>[<br/>  "qemu-guest-agent"<br/>]</pre> | no |
| <a name="input_cloud_init_runcmd"></a> [cloud\_init\_runcmd](#input\_cloud\_init\_runcmd) | n/a | `list(string)` | <pre>[<br/>  "systemctl enable qemu-guest-agent",<br/>  "systemctl start qemu-guest-agent"<br/>]</pre> | no |
| <a name="input_cloudinit_datastore_id"></a> [cloudinit\_datastore\_id](#input\_cloudinit\_datastore\_id) | Proxmox datastore ID for cloud-init snippets | `string` | n/a | yes |
| <a name="input_cpu_core_number"></a> [cpu\_core\_number](#input\_cpu\_core\_number) | cpu core number | `number` | n/a | yes |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | CPU type for the VM | `string` | `"x86-64-v2-AES"` | no |
| <a name="input_disk_datastore_id"></a> [disk\_datastore\_id](#input\_disk\_datastore\_id) | Proxmox datastore ID for VM disks | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in GB | `number` | n/a | yes |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | memory size | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | VM name | `string` | n/a | yes |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | Proxmox network bridge name | `string` | n/a | yes |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node name | `string` | n/a | yes |
| <a name="input_os_image_id"></a> [os\_image\_id](#input\_os\_image\_id) | Proxmox file ID for the OS image (e.g. from proxmox\_virtual\_environment\_download\_file) | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key for VM access | `string` | n/a | yes |
| <a name="input_tailscale_oauth_client_id"></a> [tailscale\_oauth\_client\_id](#input\_tailscale\_oauth\_client\_id) | Tailscale OAuth client ID | `string` | `""` | no |
| <a name="input_tailscale_tags"></a> [tailscale\_tags](#input\_tailscale\_tags) | Tailscale ACL tags (without 'tag:' prefix) | `list(string)` | <pre>[<br/>  "vm"<br/>]</pre> | no |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | Password for VM user (hashed) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses) | n/a |
<!-- END_TF_DOCS -->