# proxmox/vm

cloud-init プロビジョニングとオプションの Tailscale 統合を備えた Proxmox VM を作成する Terraform モジュール。

## 機能

- 任意の URL からクラウドイメージをダウンロード（デフォルト: Ubuntu 24.04 LTS Noble）
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
module "vm" {
  source = "github.com/maooz4426/maoz-terraform-modules//proxmox/vm?ref=main"

  name            = "my-vm"
  node_name       = "pve"
  cpu_core_number = 2
  memory_size     = 2048
  disk_size       = 20

  image_datastore_id     = "local"
  cloudinit_datastore_id = "local"
  disk_datastore_id      = "local-lvm"
  network_bridge         = "vmbr0"

  ssh_public_key = file("~/.ssh/id_ed25519.pub")
  user_password  = "<ハッシュ化済みパスワード>"
}
```

### Tailscale 有効化

```hcl
module "vm" {
  source = "git::https://github.com/maooz4426/maoz-terraform-modules.git//proxmox/vm?ref=main"

  name            = "my-vm"
  node_name       = "pve"
  cpu_core_number = 2
  memory_size     = 4096
  disk_size       = 40

  image_datastore_id     = "local"
  cloudinit_datastore_id = "local"
  disk_datastore_id      = "local-lvm"
  network_bridge         = "vmbr0"

  ssh_public_key = file("~/.ssh/id_ed25519.pub")
  user_password  = "<ハッシュ化済みパスワード>"

  tailscale_oauth_client_id = var.tailscale_oauth_client_id
  tailscale_tags            = ["vm", "server"]
}
```

## 入力変数

| 名前 | 型 | デフォルト | 必須 | 説明 |
|---|---|---|---|---|
| `name` | `string` | — | yes | VM 名 |
| `node_name` | `string` | — | yes | Proxmox ノード名 |
| `cpu_core_number` | `number` | — | yes | CPU コア数 |
| `memory_size` | `number` | — | yes | メモリサイズ (MB) |
| `disk_size` | `number` | — | yes | ディスクサイズ (GB) |
| `image_datastore_id` | `string` | — | yes | クラウドイメージの保存先データストア ID |
| `cloudinit_datastore_id` | `string` | — | yes | cloud-init スニペットの保存先データストア ID |
| `disk_datastore_id` | `string` | — | yes | VM ディスクの保存先データストア ID |
| `network_bridge` | `string` | — | yes | Proxmox ネットワークブリッジ名（例: `vmbr0`）|
| `ssh_public_key` | `string` | — | yes | VM に注入する SSH 公開鍵 |
| `user_password` | `string` | — | yes | VM ユーザーのハッシュ化済みパスワード（sensitive）|
| `image_url` | `string` | Ubuntu 24.04 LTS Noble | no | ダウンロードするクラウドイメージの URL |
| `cpu_type` | `string` | `"x86-64-v2-AES"` | no | CPU タイプ |
| `cloud_init_packages` | `list(string)` | `["qemu-guest-agent"]` | no | cloud-init でインストールするパッケージ |
| `cloud_init_runcmd` | `list(string)` | qemu-guest-agent の有効化・起動 | no | cloud-init で実行するコマンド |
| `tailscale_oauth_client_id` | `string` | `""` | no | Tailscale OAuth クライアント ID。空文字で Tailscale を無効化 |
| `tailscale_tags` | `list(string)` | `["vm"]` | no | Tailscale ACL タグ（`tag:` プレフィックスは不要）|

## 出力値

| 名前 | 説明 |
|---|---|
| `ip_addresses` | VM の IPv4 アドレス一覧 |

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
