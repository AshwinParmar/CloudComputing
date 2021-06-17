#locals {
#  vpc_id           = "vpc-fc13ae96"
#  subnet_id        = "subnet-7f268033"
#  ssh_user         = "ubuntu"
#  key_name         = "devops"

#  # Please update filename if different
#  private_key_path = "keys/devops.pem"
#}

provider "aws" {
  region = var.aws_region_id

  # Profile path available at $HOME/.aws/
  # Setup your `aws configure` command
  profile = var.aws_profile
}

resource "aws_security_group" "nginx" {
  name   = "nginx_access"
  vpc_id = var.aws_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx" {
  ami                         = var.aws_image_id
  subnet_id                   = var.subnet_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.nginx.id]
  key_name                    = var.aws_key_name

  provisioner "remote-exec" {
      inline = ["echo 'Wait until SSH to AWS is ready!'"]

      connection {
          type          =   "ssh"
          user          =   var.aws_ssh_user
          private_key   =   file(var.aws_private_key_path)
          host          =   aws_instance.nginx.public_ip
      }
  }

  provisioner "local-exec" {
      command = "ansible-playbook   -i  ${aws_instance.nginx.public_ip}, --private-key ${var.aws_private_key_path} nginx.yaml"
  }

  lifecycle {
    prevent_destroy = true
  }

}

output "nginx_ip" {
    value = aws_instance.nginx.public_ip
}
output "nginx_private_ip" {
    value = aws_instance.nginx.private_ip
}