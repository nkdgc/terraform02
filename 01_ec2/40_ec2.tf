# EC2インスタンスの作成
# data "aws_ami" "ubuntu" {
#   most_recent = true
# 
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }
# 
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# 
#   owners = ["099720109477"] # Canonical
# }
# 
# resource "aws_instance" "web" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"
# 
#   tags = {
#     Name = "HelloWorld"
#   }
# }

# セキュリティグループの作成
resource "aws_security_group" "ubuntu-web-server-sg" {
  name   = "ubuntu-web-server-sg"
  vpc_id = aws_vpc.terraform02-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.ubuntu-web-server-alb-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ubuntu-web-server" {
  ami                    = "ami-0b20f552f63953f0e" # Ubuntu Server 24.04
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.terraform02-subnet-private01
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  user_data              = <<EOF
#! /bin/bash
sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
EOF
  tags = {
    Name = "ubuntu-web-server"
  }
}

