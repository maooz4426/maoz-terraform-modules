locals {
  tailscale_enabled = var.tailscale_oauth_client_id != ""

  all_runcmd = concat(
    var.cloud_init_runcmd,
    [for k in tailscale_tailnet_key.auth_key : join("\n", [
      "curl -fsSL https://tailscale.com/install.sh | sh",
      "tailscale up --auth-key=${k.key}",
    ])]
  )
}

resource "tailscale_tailnet_key" "auth_key" {
  # tailscale使わない時はfalseにするため
  count         = local.tailscale_enabled ? 1 : 0
  reusable      = true
  ephemeral     = false
  preauthorized = true
  tags          = [for t in var.tailscale_tags : "tag:${t}"]
}

resource "proxmox_download_file" "cloud_image" {
  content_type        = "iso"
  datastore_id        = var.image_datastore_id
  node_name           = var.node_name
  url                 = var.image_url
  file_name           = basename(var.image_url)
  overwrite           = false
  overwrite_unmanaged = true
}

resource "proxmox_virtual_environment_file" "cloud_init_user_data" {
  content_type = "snippets"
  datastore_id = var.cloudinit_datastore_id
  node_name    = var.node_name

  lifecycle {
    ignore_changes = [source_raw]
  }

  source_raw {
    file_name = "${var.name}-user-data.yaml"
    data = templatefile("${path.module}/templates/cloud-init.yaml.tpl", {
      name           = var.name
      user_password  = var.user_password
      ssh_public_key = var.ssh_public_key
      packages       = var.cloud_init_packages
      runcmd         = local.all_runcmd
    })
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.name
  node_name = var.node_name

  cpu {
    cores = var.cpu_core_number
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory_size
  }

  disk {
    datastore_id = var.disk_datastore_id
    file_id      = proxmox_download_file.cloud_image.id
    interface    = "scsi0"
    size         = var.disk_size
  }

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

  # qemu-guest-agentを起動させる
  # https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent
  agent {
    enabled = true
    timeout = "120s"
  }

  lifecycle {
    ignore_changes = [
      initialization,
    ]
  }
}

