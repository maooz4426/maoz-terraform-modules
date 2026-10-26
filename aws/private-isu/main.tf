# private-isu (ISUCON練習用ベンチマーク対象アプリ) 稼働用 EC2
# 公式 CloudFormation テンプレート相当の構成(専用VPC、サーバー、ベンチマーカー)。接続はSSMのみ
# AMI は catatsuy/private-isu の公開AMI(ベンチマーカー同梱)。サーバーとベンチマーカーで共用する

resource "aws_vpc" "private_isu" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "private-isu"
  }
}

resource "aws_subnet" "private_isu" {
  vpc_id            = aws_vpc.private_isu.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "private-isu"
  }
}

resource "aws_internet_gateway" "private_isu" {
  vpc_id = aws_vpc.private_isu.id

  tags = {
    Name = "private-isu"
  }
}

resource "aws_route_table" "private_isu" {
  vpc_id = aws_vpc.private_isu.id

  tags = {
    Name = "private-isu"
  }
}

resource "aws_route" "private_isu_public" {
  route_table_id         = aws_route_table.private_isu.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.private_isu.id
}

resource "aws_route_table_association" "private_isu" {
  subnet_id      = aws_subnet.private_isu.id
  route_table_id = aws_route_table.private_isu.id
}

resource "aws_security_group" "private_isu" {
  name        = "private-isu"
  description = "private-isu HTTP/HTTPS from home IP and all traffic inside VPC"
  vpc_id      = aws_vpc.private_isu.id

  ingress {
    description = "HTTP from home"
    from_port   = 80
    to_port     = 80
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
    cidr_blocks = [aws_vpc.private_isu.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-isu"
  }
}

resource "aws_iam_role" "private_isu_ec2" {
  name = "private_isu_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "private_isu_ec2_ssm" {
  role       = aws_iam_role.private_isu_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "private_isu_ec2" {
  name = "private_isu_ec2_profile"
  role = aws_iam_role.private_isu_ec2.name
}

resource "aws_instance" "server" {
  ami                    = var.ami_id
  instance_type          = var.server_instance_type
  subnet_id              = aws_subnet.private_isu.id
  private_ip             = var.server_private_ip
  vpc_security_group_ids = [aws_security_group.private_isu.id]
  iam_instance_profile   = aws_iam_instance_profile.private_isu_ec2.name

  tags = {
    Name = "private-isu-server"
  }
}

resource "aws_instance" "benchmarker" {
  ami                    = var.ami_id
  instance_type          = var.benchmarker_instance_type
  subnet_id              = aws_subnet.private_isu.id
  private_ip             = var.benchmarker_private_ip
  vpc_security_group_ids = [aws_security_group.private_isu.id]
  iam_instance_profile   = aws_iam_instance_profile.private_isu_ec2.name

  tags = {
    Name = "private-isu-benchmarker"
  }
}

resource "aws_eip" "server" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.private_isu]

  tags = {
    Name = "private-isu-server"
  }
}

resource "aws_eip" "benchmarker" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.private_isu]

  tags = {
    Name = "private-isu-benchmarker"
  }
}

resource "aws_eip_association" "server" {
  instance_id   = aws_instance.server.id
  allocation_id = aws_eip.server.id
}

resource "aws_eip_association" "benchmarker" {
  instance_id   = aws_instance.benchmarker.id
  allocation_id = aws_eip.benchmarker.id
}
