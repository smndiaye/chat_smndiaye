provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.deploy_server.id}"
  allocation_id = "${aws_eip.deploy_server.id}"
}

data "aws_ami" "deploy_server" {
  most_recent = true

  filter {
    name   = "name"
    values = ["deploy_server_*"]
  }

  owners = ["self"]
}

resource "aws_instance" "deploy_server" {
  ami             = "${data.aws_ami.deploy_server.id}"
  key_name        = "${aws_key_pair.deploy_server_key.key_name}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.deploy_server-sg.name}"]

  tags {
    Name = "deploy_server"
  }
}

resource "aws_eip" "deploy_server" {
  vpc = true
}

resource "aws_security_group" "deploy_server-sg" {
  name   = "deploy_server-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deploy_server_key" {
  key_name   = "ssh_key"
  public_key = "${var.ssh_key_pub}"
}
