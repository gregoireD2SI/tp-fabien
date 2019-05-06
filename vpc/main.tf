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

resource "aws_internet_gateway" "fabien_gw" {
  vpc_id = "${aws_vpc.vpc_fabien.id}"

  tags {
    Name = "${var.project_name}_gw"
  }
}

resource "aws_route_table" "fabien_rt_public" {
  vpc_id = "${aws_vpc.vpc_fabien.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.fabien_gw.id}"
  }

  tags {
    Name = "${var.project_name}_public_rt"
  }
}

resource "aws_route_table_association" "fabien_association_rt" {
  subnet_id      = "${aws_subnet.fabien_sn_public.id}"
  route_table_id = "${aws_route_table.fabien_rt_public.id}"
}
