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
