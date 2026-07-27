resource "proxmox_virtual_environment_file" "cloud_init_user_data" {
  content_type = "snippets"
  datastore_id = var.cloudinit_datastore_id
  node_name    = var.node_name

  source_raw {
    file_name = "${var.host_name}-user-data.yaml"
    data = templatefile("${path.module}/templates/cloud-init.yaml.tpl", {
      host_name       = var.host_name
      user_name       = var.user_name
      user_password   = var.user_password
      ssh_public_keys = var.ssh_public_keys
    })
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name       = var.host_name
  node_name  = var.node_name
  boot_order = ["scsi0"]

  cpu {
    cores = var.cpu_core_number
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory_size
  }

  disk {
    datastore_id = var.disk_datastore_id
    file_id      = var.os_image_id
    interface    = "scsi0"
    size         = var.disk_size
  }

  serial_device {}

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.cloud_init_user_data.id
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  # qemu-guest-agent は Terraform が VM の IP を取得するために必須
  # https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent
  agent {
    enabled = true
    timeout = "300s"
  }
}
