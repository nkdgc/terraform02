provider "aws" {
  region = "${local.region}"
  default_tags {
    tags = {
      Owner     = "ndeguchi"
      Terraform = "true"
    }
  }
}

