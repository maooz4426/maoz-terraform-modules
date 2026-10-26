# aws/private-isu

ISUCON 練習用アプリ private-isu の稼働環境を作成する Terraform モジュール。専用 VPC、サーバーとベンチマーカーの EC2 (各 EIP 付き)、SSM 接続用の IAM ロールを作成する。接続は SSM Session Manager のみ。

## usage

```hcl
module "private_isu" {
  source = "github.com/maooz4426/maoz-terraform-modules//aws/private-isu?ref=main"

  home_ip_cidr = "203.0.113.1/32"
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
