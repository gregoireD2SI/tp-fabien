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

resource "aws_subnet" "fabien_sn_public" {
  vpc_id            = "${aws_vpc.vpc_fabien.id}"
  cidr_block        = "172.23.1.0/24"
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "fabien_sn_private" {
  vpc_id            = "${aws_vpc.vpc_fabien.id}"
  cidr_block        = "172.23.10.0/24"
  availability_zone = "${var.region}b"
}
