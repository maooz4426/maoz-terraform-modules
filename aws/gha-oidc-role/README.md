# aws/gha-oidc-role

GitHub Actions の OIDC を信頼して `sts:AssumeRoleWithWebIdentity` を許可する IAM ロールを作成し、指定したポリシードキュメントを IAM ポリシーとしてアタッチする Terraform モジュール。特定リポジトリからの GitHub Actions ワークフローに AWS 権限を付与する用途に使う。

## usage

```hcl
data "aws_iam_policy_document" "this" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::my-bucket/*"]
  }
}

module "gha_oidc_role" {
  source = "github.com/maooz4426/maoz-terraform-modules//aws/gha-oidc-role?ref=main"

  role_name         = "github-actions-deploy"
  github_repo       = "maooz4426/my-app"
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
  policy_document   = data.aws_iam_policy_document.this.json
}
```

<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attachment_name"></a> [attachment\_name](#input\_attachment\_name) | n/a | `string` | `null` | no |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | n/a | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | n/a | `string` | n/a | yes |
| <a name="input_policy_document"></a> [policy\_document](#input\_policy\_document) | n/a | `string` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | nullにしてmovedした際にも対応できるように movedの際はcollasceを使用する | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END_TF_DOCS -->
