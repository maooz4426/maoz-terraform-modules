# proxmox/vm

cloud-init プロビジョニングとオプションの Tailscale 統合を備えた Proxmox VM を作成する Terraform モジュール。

## 機能

- 任意の OS イメージ（ISO / qcow2 / img など）を外部から注入して起動
- cloud-init によるプロビジョニング（ユーザー、SSH 鍵、パッケージ、カスタムコマンド）
- OAuth クライアントを使った Tailscale のインストールと登録（オプション）
- QEMU ゲストエージェントをデフォルトで有効化
- DHCP による IPv4 ネットワーク設定

## 要件

| プロバイダー | バージョン |
|---|---|
| [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox) | ~> 0.77 |
| [tailscale/tailscale](https://registry.terraform.io/providers/tailscale/tailscale) | ~> 0.17 |

## 使用例

### 最小構成

```hcl
resource "proxmox_virtual_environment_download_file" "ubuntu" {
  node_name    = "pve"
  content_type = "import"
  datastore_id = "local"
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

module "vm" {
  source = "github.com/maooz4426/maoz-terraform-modules//proxmox/vm?ref=main"

  name            = "my-vm"
  node_name       = "pve"
  cpu_core_number = 2
  memory_size     = 2048
  disk_size       = 20

  os_image_id            = proxmox_virtual_environment_download_file.ubuntu.id
  cloudinit_datastore_id = "local"
  disk_datastore_id      = "local-lvm"
  network_bridge         = "vmbr0"

  ssh_public_key = file("~/.ssh/id_ed25519.pub")
  user_password  = "<ハッシュ化済みパスワード>"
}
```

### Tailscale 有効化

```hcl
resource "proxmox_virtual_environment_download_file" "ubuntu" {
  node_name    = "pve"
  content_type = "import"
  datastore_id = "local"
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

module "vm" {
  source = "github.com/maooz4426/maoz-terraform-modules//proxmox/vm?ref=main"

  name            = "my-vm"
  node_name       = "pve"
  cpu_core_number = 2
  memory_size     = 4096
  disk_size       = 40

  os_image_id            = proxmox_virtual_environment_download_file.ubuntu.id
  cloudinit_datastore_id = "local"
  disk_datastore_id      = "local-lvm"
  network_bridge         = "vmbr0"

  ssh_public_key = file("~/.ssh/id_ed25519.pub")
  user_password  = "<ハッシュ化済みパスワード>"

  tailscale_oauth_client_id = var.tailscale_oauth_client_id
  tailscale_tags            = ["vm", "server"]
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 補足

### パスワードのハッシュ化

`user_password` にはハッシュ化済みのパスワードを指定する必要があります。以下のコマンドで生成できます。

```sh
openssl passwd -6
```

### Tailscale

Tailscale はデフォルトで無効です。`tailscale_oauth_client_id` に値を設定すると有効になり、cloud-init 時に自動でインストール・登録されます。

`tailscale_tags` は `tag:` プレフィックスなしで指定してください。モジュール側で自動的に付与されます。

### cloud-init の変更について

cloud-init の設定は VM 作成時にのみ適用されます。作成後に `cloud_init_packages` や `cloud_init_runcmd` などを変更しても、既存の VM には反映されません（初期化ブロックに `lifecycle.ignore_changes` が設定されています）。

