resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}


data "aws_region" "current" {}

