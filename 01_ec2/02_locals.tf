locals {
    name-prefix = "tf02"
    region = "ap-northeast-1"
}

variable "env" {}

# Account ID を動的に取得するために定義
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}
