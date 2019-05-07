resource "aws_instance" "fabien_instance_web" {
  ami           = "ami-0d77397e"                      # Ubuntu 16.04
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.fabien_sn_public.id}"

  key_name = "gregoire"

  tags = {
    Name = "fabien_ec2"
  }
}

resource "aws_eip" "fabien_eip" {
  vpc = true

  tags = {
    Name = "fabien_eip"
  }
}

resource "aws_eip_association" "fabien_eip_assoc" {
  instance_id   = "${aws_instance.fabien_instance_web.id}"
  allocation_id = "${aws_eip.fabien_eip.id}"
}

resource "aws_security_group" "fabien_sg_ec2" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.vpc_fabien.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_all_ssh"
  }
}


resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "${aws_security_group.fabien_sg_ec2.id}"
  network_interface_id = "${aws_instance.fabien_instance_web.primary_network_interface_id}"
}

