<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.77 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | ~> 0.77 |

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_container.this](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | Number of CPU cores | `number` | `2` | no |
| <a name="input_description"></a> [description](#input\_description) | LXC container description | `string` | `""` | no |
| <a name="input_device_passthrough"></a> [device\_passthrough](#input\_device\_passthrough) | List of devices to pass through to the container | <pre>list(object({<br/>    path = string<br/>  }))</pre> | `[]` | no |
| <a name="input_disk_datastore_id"></a> [disk\_datastore\_id](#input\_disk\_datastore\_id) | Proxmox datastore ID for container disk | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in GB | `number` | `20` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | LXC container hostname | `string` | n/a | yes |
| <a name="input_memory_dedicated"></a> [memory\_dedicated](#input\_memory\_dedicated) | Dedicated memory in MB | `number` | `2048` | no |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | Proxmox network bridge name | `string` | n/a | yes |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node name | `string` | n/a | yes |
| <a name="input_os_template_file_id"></a> [os\_template\_file\_id](#input\_os\_template\_file\_id) | Proxmox file ID for the OS template | `string` | n/a | yes |
| <a name="input_ssh_public_keys"></a> [ssh\_public\_keys](#input\_ssh\_public\_keys) | SSH public keys for container access | `list(string)` | n/a | yes |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | LXC container ID | `number` | n/a | yes |
<!-- END_TF_DOCS -->