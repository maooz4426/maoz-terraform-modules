variable "home_ip_cidr" {
  description = "SSH/HTTPS の接続を許可する自宅 IP の CIDR"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC の CIDR"
  type        = string
  default     = "10.14.0.0/16"
}

variable "subnet_cidr" {
  description = "サブネットの CIDR"
  type        = string
  default     = "10.14.1.0/24"
}

variable "availability_zone" {
  description = "サブネットと EC2 を配置する AZ"
  type        = string
  default     = "ap-northeast-1a"
}

variable "ami_id" {
  description = "サーバーとベンチマーカーに使う AMI ID (リージョン固有)"
  type        = string
  default     = "ami-0fcf9e8e8675a9ee4"
}

variable "server_instance_type" {
  description = "サーバーのインスタンスタイプ"
  type        = string
  default     = "c5.large"
}

variable "benchmarker_instance_type" {
  description = "ベンチマーカーのインスタンスタイプ"
  type        = string
  default     = "c5.xlarge"
}

variable "server_private_ip" {
  description = "サーバーのプライベート IP"
  type        = string
  default     = "10.14.1.10"
}

variable "benchmarker_private_ip" {
  description = "ベンチマーカーのプライベート IP"
  type        = string
  default     = "10.14.1.20"
}

variable "root_volume_size" {
  description = "ルートボリュームのサイズ (GiB)"
  type        = number
  default     = 20
}
