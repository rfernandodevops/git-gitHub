# "aws" as the provider

provider "aws" {
    region = "ap-southeast-1"
    access_key = "XXXX"
    secret_key = "XXXX"
}

resource "aws_instance" "UBSRV001" {
  ami = "ami-0dad20bd1b9c8c004" # Image: Ubuntu Server 18.04 LTS (HVM), SSD
  instance_type = "t2.micro" # Instance Spec
  security_groups = ["${aws_security_group.allow_ssh.name}"]
  key_name ="KP01"
}

# Create aws_security_group for SSH access

resource "aws_security_group" "allow_ssh" {
  name        = "allow ssh"
  description = "only ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "showPublicIP" {
  value = "${aws_instance.UBSRV001.*.public_dns}"
}
