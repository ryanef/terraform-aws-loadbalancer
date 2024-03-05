resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

data "aws_region" "current" {}

data "aws_subnets" "this" {
  tags = {
    Name = "${var.vpc_name}-${var.environment}-public-sn"
  }
}

data "aws_vpc" "this" {
  tags = {
    Name = "${var.vpc_name}-${var.environment}"
 
  }
}
