# Security Group

resource "aws_security_group" "docker_instance" {
  name = var.cluster_name

  tags = {
    Name = var.cluster_name
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

# EC2 instance

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_eip" "docker_instance" {
  vpc = true
}

resource "aws_instance" "docker_instance" {
  instance_type = var.instance_type

  ami = data.aws_ami.amazon_linux_2.id

  key_name = var.aws_key_pair_name

  vpc_security_group_ids = [
    aws_security_group.docker_instance.id,
  ]

  tags = {
    Name = var.cluster_name
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/scripts/init-web-instance.sh",
    ]
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "15"
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  connection {
    host = self.public_ip
    user = "ec2-user"
    private_key = var.aws_key_pair_secret_key
  }
}

resource "aws_eip_association" "docker_instance_assoc" {
  instance_id = aws_instance.docker_instance.id
  allocation_id = aws_eip.docker_instance.id
}
