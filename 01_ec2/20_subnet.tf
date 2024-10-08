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
    Name = "${var.env}-public-subnet01"
  }
}

# public02
resource "aws_subnet" "terraform02-subnet-public02" {
  vpc_id                  = aws_vpc.terraform02-vpc.id
  cidr_block              = "10.200.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-subnet02"
  }
}

# private01
resource "aws_subnet" "terraform02-subnet-private01" {
  vpc_id                  = aws_vpc.terraform02-vpc.id
  cidr_block              = "10.200.10.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-private-subnet01"
  }
}

# private02
resource "aws_subnet" "terraform02-subnet-private02" {
  vpc_id                  = aws_vpc.terraform02-vpc.id
  cidr_block              = "10.200.11.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-private-subnet02"
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
    Name = "${var.env}-rtb-public"
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
    Name = "${var.env}-rtb-private"
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
