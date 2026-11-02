# ISUCON14 練習用 EC2
# サーバーは第三者(matsuu/aws-isucon の Packer)が公開したAMIから作成する。公式AMI ami-0e334c50145a3ee41 はこのアカウントで利用できなくなった
# ベンチマーカーは Ubuntu 24.04 に isucon14 の bench をビルドする。接続はSSHとSSM
# 22/443 は var.home_ip_cidr からだけ許可する

resource "aws_vpc" "isucon14" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "isucon14"
  }
}

resource "aws_subnet" "isucon14" {
  vpc_id            = aws_vpc.isucon14.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "isucon14"
  }
}

resource "aws_internet_gateway" "isucon14" {
  vpc_id = aws_vpc.isucon14.id

  tags = {
    Name = "isucon14"
  }
}

resource "aws_route_table" "isucon14" {
  vpc_id = aws_vpc.isucon14.id

  tags = {
    Name = "isucon14"
  }
}

resource "aws_route" "isucon14_public" {
  route_table_id         = aws_route_table.isucon14.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.isucon14.id
}

resource "aws_route_table_association" "isucon14" {
  subnet_id      = aws_subnet.isucon14.id
  route_table_id = aws_route_table.isucon14.id
}

resource "aws_security_group" "isucon14" {
  name        = "isucon14"
  description = "isucon14 SSH/HTTPS from home IP and all traffic inside VPC"
  vpc_id      = aws_vpc.isucon14.id

  ingress {
    description = "SSH from home"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.home_ip_cidr]
  }

  ingress {
    description = "HTTPS from home"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.home_ip_cidr]
  }

  ingress {
    description = "All traffic inside VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.isucon14.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "isucon14"
  }
}

resource "aws_iam_role" "isucon14_ec2" {
  name = "isucon14_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "isucon14_ec2_ssm" {
  role       = aws_iam_role.isucon14_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "isucon14_ec2" {
  name = "isucon14_ec2_profile"
  role = aws_iam_role.isucon14_ec2.name
}

resource "aws_instance" "isucon14_server" {
  ami                    = var.ami_id
  instance_type          = var.server_instance_type
  subnet_id              = aws_subnet.isucon14.id
  private_ip             = var.server_private_ip
  vpc_security_group_ids = [aws_security_group.isucon14.id]
  iam_instance_profile   = aws_iam_instance_profile.isucon14_ec2.name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
  }

  tags = {
    Name = "isucon14-server"
  }
}

resource "aws_instance" "isucon14_benchmarker" {
  ami                    = var.ami_id
  instance_type          = var.benchmarker_instance_type
  subnet_id              = aws_subnet.isucon14.id
  private_ip             = var.benchmarker_private_ip
  vpc_security_group_ids = [aws_security_group.isucon14.id]
  iam_instance_profile   = aws_iam_instance_profile.isucon14_ec2.name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
  }

  # bench/go.mod は Go 1.23 を要求する。apt の golang-go は 1.22 なので、go が Go 1.23 の toolchain を自動取得する
  user_data = <<-EOT
    #!/bin/bash
    set -eux
    echo "${var.server_private_ip} isuride.xiv.isucon.net" >> /etc/hosts
    apt-get update
    apt-get install -y git golang-go
    sudo -u ubuntu git clone https://github.com/isucon/isucon14.git /home/ubuntu/isucon14
    cd /home/ubuntu/isucon14/bench
    sudo -u ubuntu go build -ldflags "-s -w" -o /home/ubuntu/bench
  EOT

  # AMI の更新でインスタンスを作り直さない
  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name = "isucon14-benchmarker"
  }
}

resource "aws_eip" "isucon14_server" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.isucon14]

  tags = {
    Name = "isucon14-server"
  }
}

resource "aws_eip" "isucon14_benchmarker" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.isucon14]

  tags = {
    Name = "isucon14-benchmarker"
  }
}

resource "aws_eip_association" "isucon14_server" {
  instance_id   = aws_instance.isucon14_server.id
  allocation_id = aws_eip.isucon14_server.id
}

resource "aws_eip_association" "isucon14_benchmarker" {
  instance_id   = aws_instance.isucon14_benchmarker.id
  allocation_id = aws_eip.isucon14_benchmarker.id
}
