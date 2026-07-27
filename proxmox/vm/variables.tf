variable "host_name" {
  description = "VM name"
  type        = string
}

variable "user_name" {
  description = "VM user name"
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

variable "ssh_public_keys" {
  description = "SSH public keys for VM access"
  type        = list(string)
}

variable "user_password" {
  description = "Password for VM user (hashed)"
  type        = string
  sensitive   = true
}
