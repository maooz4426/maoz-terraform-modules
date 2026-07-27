resource "proxmox_virtual_environment_container" "this" {
  node_name    = var.node_name
  vm_id        = var.vm_id
  description  = var.description
  started      = true
  unprivileged = true

  operating_system {
    template_file_id = var.os_template_file_id
    type             = "debian"
  }

  initialization {
    hostname = var.hostname
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_account {
      keys = var.ssh_public_keys
    }
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_dedicated
  }

  disk {
    datastore_id = var.disk_datastore_id
    size         = var.disk_size
  }

  network_interface {
    name   = "eth0"
    bridge = var.network_bridge
  }

  dynamic "device_passthrough" {
    for_each = var.device_passthrough
    content {
      path = device_passthrough.value.path
    }
  }

  features {
    nesting = true
  }
}
