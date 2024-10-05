# セキュリティグループの作成
resource "aws_security_group" "ubuntu-web-server-alb-sg" {
  name   = "ubuntu-web-server-alb-sg"
  vpc_id = aws_vpc.terraform02-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["27.0.3.144/28"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
