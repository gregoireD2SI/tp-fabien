### Provider
provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "vpc_fabien" {
  cidr_block = "172.23.0.0/16"

  tags {
    Name = "${var.project_name}"
  }
}
