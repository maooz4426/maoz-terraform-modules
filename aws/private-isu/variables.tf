variable "home_ip_cidr" {
  description = "HTTP/HTTPS の接続を許可する自宅 IP の CIDR"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC の CIDR"
  type        = string
  default     = "192.168.0.0/16"
}

variable "subnet_cidr" {
  description = "サブネットの CIDR"
  type        = string
  default     = "192.168.1.0/24"
}

variable "availability_zone" {
  description = "サブネットと EC2 を配置する AZ"
  type        = string
  default     = "ap-northeast-1a"
}

variable "ami_id" {
  description = "catatsuy/private-isu の公開 AMI ID (リージョン固有)"
  type        = string
  default     = "ami-09201e964bee13733"
}

variable "server_instance_type" {
  description = "サーバーのインスタンスタイプ"
  type        = string
  default     = "c6i.large"
}

variable "benchmarker_instance_type" {
  description = "ベンチマーカーのインスタンスタイプ"
  type        = string
  default     = "c6i.xlarge"
}

variable "server_private_ip" {
  description = "サーバーの private IP"
  type        = string
  default     = "192.168.1.10"
}

variable "benchmarker_private_ip" {
  description = "ベンチマーカーの private IP"
  type        = string
  default     = "192.168.1.20"
}
