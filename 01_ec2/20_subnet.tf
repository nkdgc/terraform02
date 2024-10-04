# -----------------------------------------------------------
# Subnet
# -----------------------------------------------------------

# public01
resource "aws_subnet" "terraform02-subnet-public01" {
  vpc_id                  = aws_vpc.terraform02-vpc.id
  cidr_block              = "10.200.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform02-subnet-public01"
  }
}

# public02
resource "aws_subnet" "terraform02-subnet-public02" {
  vpc_id                  = aws_vpc.terraform02-vpc.id
  cidr_block              = "10.200.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform02-subnet-public02"
  }
}

# private01
resource "aws_subnet" "terraform02-subnet-private01" {
  vpc_id                  = aws_vpc.terraform02-vpc.id
  cidr_block              = "10.200.10.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform02-subnet-private01"
  }
}

# private02
resource "aws_subnet" "terraform02-subnet-private02" {
  vpc_id                  = aws_vpc.terraform02-vpc.id
  cidr_block              = "10.200.11.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform02-subnet-private02"
  }
}

# -----------------------------------------------------------
# Route Table
# -----------------------------------------------------------

# public用のルートテーブル作成
resource "aws_route_table" "terraform02-rtb-public" {
  vpc_id = aws_vpc.terraform02-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform02-igw01.id
  }
  tags = {
    Name = "terraform02-rtb-public"
  }
}

# public用のルートテーブルを puclic01 subnet に紐付け
resource "aws_route_table_association" "terraform02-subnet-rtb-public-assoc-01" {
  subnet_id      = aws_subnet.terraform02-subnet-public01.id
  route_table_id = aws_route_table.terraform02-rtb-public.id
}

# public用のルートテーブルを puclic02 subnet に紐付け
resource "aws_route_table_association" "terraform02-subnet-rtb-public-assoc-02" {
  subnet_id      = aws_subnet.terraform02-subnet-public02.id
  route_table_id = aws_route_table.terraform02-rtb-public.id
}

# private用のルートテーブル作成
resource "aws_route_table" "terraform02-rtb-private" {
  vpc_id = aws_vpc.terraform02-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.terraform02-natgw01.id
  }
  tags = {
    Name = "terraform02-rtb-private"
  }
}

# private用のルートテーブルを private01 subnet に紐付け
resource "aws_route_table_association" "terraform02-subnet-rtb-private-assoc-01" {
  subnet_id      = aws_subnet.terraform02-subnet-private01.id
  route_table_id = aws_route_table.terraform02-rtb-private.id
}

# private用のルートテーブルを private02 subnet に紐付け
resource "aws_route_table_association" "terraform02-subnet-rtb-private-assoc-02" {
  subnet_id      = aws_subnet.terraform02-subnet-private02.id
  route_table_id = aws_route_table.terraform02-rtb-private.id
}

# # セキュリティグループの作成
# resource "aws_security_group" "sample_sg" {
#   name   = "sample-sg"
#   vpc_id = aws_vpc.terraform02-vpc.id
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

