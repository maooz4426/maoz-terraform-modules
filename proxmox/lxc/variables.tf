variable "node_name" {
  description = "Proxmox node name"
  type        = string
}

variable "vm_id" {
  description = "LXC container ID"
  type        = number
}

variable "hostname" {
  description = "LXC container hostname"
  type        = string
}

variable "description" {
  description = "LXC container description"
  type        = string
  default     = ""
}

variable "os_template_file_id" {
  description = "Proxmox file ID for the OS template"
  type        = string
}

variable "ssh_public_keys" {
  description = "SSH public keys for container access"
  type        = list(string)
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory_dedicated" {
  description = "Dedicated memory in MB"
  type        = number
  default     = 2048
}

variable "disk_datastore_id" {
  description = "Proxmox datastore ID for container disk"
  type        = string
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "network_bridge" {
  description = "Proxmox network bridge name"
  type        = string
}

variable "device_passthrough" {
  description = "List of devices to pass through to the container"
  type = list(object({
    path = string
  }))
  default = []
}
