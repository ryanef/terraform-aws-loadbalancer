resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

data "aws_region" "current" {}

data "aws_subnets" "this" {
  tags = {
    Name = "${var.name}-${var.environment}-public-sn"
  }
}
