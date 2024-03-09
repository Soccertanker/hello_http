terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}


variable "vpc_id" {}

variable "key_name" {
  description = "key pair name from AWS"
  type = string
}

variable "ingress_ip" {
  description = "ip address cidr block that can access the hello http server"
  type = string
}

resource "aws_security_group" "hello_http_server" {
  name = "hello_http_app"
  vpc_id = var.vpc_id
  
  tags = {
    Name = "hello_app"
  }

  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = [var.ingress_ip]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




data "aws_ami" "al2023" {
  most_recent = true

  filter {
    name = "name"
    values = ["my_al2023_ami_*"]
  }

  owners = ["471112547167"]
}


resource "aws_instance" "app_server" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.hello_http_server.id]
  key_name = var.key_name

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

output "hostid" {
  value = aws_instance.app_server.*.public_dns
}
