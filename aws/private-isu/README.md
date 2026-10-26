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


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.benchmarker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.benchmarker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_eip_association.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_iam_instance_profile.private_isu_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.private_isu_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.private_isu_ec2_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.benchmarker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.private_isu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.private_isu_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_isu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_isu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.private_isu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private_isu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.private_isu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | catatsuy/private-isu の公開 AMI ID (リージョン固有) | `string` | `"ami-09201e964bee13733"` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | サブネットと EC2 を配置する AZ | `string` | `"ap-northeast-1a"` | no |
| <a name="input_benchmarker_instance_type"></a> [benchmarker\_instance\_type](#input\_benchmarker\_instance\_type) | ベンチマーカーのインスタンスタイプ | `string` | `"c6i.xlarge"` | no |
| <a name="input_benchmarker_private_ip"></a> [benchmarker\_private\_ip](#input\_benchmarker\_private\_ip) | ベンチマーカーの private IP | `string` | `"192.168.1.20"` | no |
| <a name="input_home_ip_cidr"></a> [home\_ip\_cidr](#input\_home\_ip\_cidr) | HTTP/HTTPS の接続を許可する自宅 IP の CIDR | `string` | n/a | yes |
| <a name="input_server_instance_type"></a> [server\_instance\_type](#input\_server\_instance\_type) | サーバーのインスタンスタイプ | `string` | `"c6i.large"` | no |
| <a name="input_server_private_ip"></a> [server\_private\_ip](#input\_server\_private\_ip) | サーバーの private IP | `string` | `"192.168.1.10"` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | サブネットの CIDR | `string` | `"192.168.1.0/24"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC の CIDR | `string` | `"192.168.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_benchmarker_ip"></a> [benchmarker\_ip](#output\_benchmarker\_ip) | private-isu ベンチマーカーの EIP |
| <a name="output_server_ip"></a> [server\_ip](#output\_server\_ip) | private-isu サーバーの EIP |
<!-- END_TF_DOCS -->
