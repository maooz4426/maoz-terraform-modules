<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.isucon14_benchmarker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.isucon14_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.isucon14_benchmarker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_eip_association.isucon14_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_iam_instance_profile.isucon14_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.isucon14_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.isucon14_ec2_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.isucon14_benchmarker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.isucon14_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.isucon14](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.isucon14_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.isucon14](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.isucon14](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.isucon14](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.isucon14](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.isucon14](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | サーバーとベンチマーカーに使う AMI ID (リージョン固有) | `string` | `"ami-0fcf9e8e8675a9ee4"` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | サブネットと EC2 を配置する AZ | `string` | `"ap-northeast-1a"` | no |
| <a name="input_benchmarker_instance_type"></a> [benchmarker\_instance\_type](#input\_benchmarker\_instance\_type) | ベンチマーカーのインスタンスタイプ | `string` | `"c5.xlarge"` | no |
| <a name="input_benchmarker_private_ip"></a> [benchmarker\_private\_ip](#input\_benchmarker\_private\_ip) | ベンチマーカーのプライベート IP | `string` | `"10.14.1.20"` | no |
| <a name="input_home_ip_cidr"></a> [home\_ip\_cidr](#input\_home\_ip\_cidr) | SSH/HTTPS の接続を許可する自宅 IP の CIDR | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | ルートボリュームのサイズ (GiB) | `number` | `20` | no |
| <a name="input_server_instance_type"></a> [server\_instance\_type](#input\_server\_instance\_type) | サーバーのインスタンスタイプ | `string` | `"c5.large"` | no |
| <a name="input_server_private_ip"></a> [server\_private\_ip](#input\_server\_private\_ip) | サーバーのプライベート IP | `string` | `"10.14.1.10"` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | サブネットの CIDR | `string` | `"10.14.1.0/24"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC の CIDR | `string` | `"10.14.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_benchmarker_public_ip"></a> [benchmarker\_public\_ip](#output\_benchmarker\_public\_ip) | isucon14 ベンチマーカーの EIP |
| <a name="output_server_public_ip"></a> [server\_public\_ip](#output\_server\_public\_ip) | isucon14 サーバーの EIP |
<!-- END_TF_DOCS -->