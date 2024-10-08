# VPCの作成
resource "aws_vpc" "terraform02-vpc" {
  cidr_block           = "10.200.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.env}-vpc"
  }
}

# インターネットゲートウェイの作成
resource "aws_internet_gateway" "terraform02-igw01" {
  vpc_id = aws_vpc.terraform02-vpc.id
  tags = {
    Name = "${var.env}-igw01"
  }
}

# NAT ゲートウェイの作成
resource "aws_eip" "terraform02-eip-natgw01" {
  # count  = 1  // 作成するEIPの数
  domain = "vpc"  // VPC内でEIPを使用（vpc = trueの代わりに）
}

resource "aws_nat_gateway" "terraform02-natgw01" {
  allocation_id = aws_eip.terraform02-eip-natgw01.id
  subnet_id     = aws_subnet.terraform02-subnet-public01.id

  tags = {
    Name = "${var.env}-natgw01"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.terraform02-igw01]
}
