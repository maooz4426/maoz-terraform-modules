variable "name" {
  description = "VM name"
  type        = string
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
}

variable "cpu_core_number" {
  description = "cpu core number"
  type        = number
}

variable "memory_size" {
  description = "memory size"
  type        = number
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
}

variable "os_image_id" {
  description = "Proxmox file ID for the OS image (e.g. from proxmox_virtual_environment_download_file)"
  type        = string
}

variable "cloudinit_datastore_id" {
  description = "Proxmox datastore ID for cloud-init snippets"
  type        = string
}

variable "disk_datastore_id" {
  description = "Proxmox datastore ID for VM disks"
  type        = string
}

variable "network_bridge" {
  description = "Proxmox network bridge name"
  type        = string
}

variable "cpu_type" {
  description = "CPU type for the VM"
  type        = string
  default     = "x86-64-v2-AES"
}

variable "cloud_init_packages" {
  type    = list(string)
  default = ["qemu-guest-agent"]
}

variable "cloud_init_runcmd" {
  type = list(string)
  default = [
    "systemctl enable qemu-guest-agent",
    "systemctl start qemu-guest-agent"
  ]
}

variable "tailscale_oauth_client_id" {
  description = "Tailscale OAuth client ID"
  type        = string
  default     = ""
}

variable "tailscale_tags" {
  description = "Tailscale ACL tags (without 'tag:' prefix)"
  type        = list(string)
  default     = ["vm"]
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "user_password" {
  description = "Password for VM user (hashed)"
  type        = string
  sensitive   = true
}

