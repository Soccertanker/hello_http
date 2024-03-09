packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "al2023" {
  ami_name = "my_al2023_ami_${local.timestamp}"
  instance_type = "t2.micro"
  region        = "${var.my_region}"
  source_ami_filter {
    filters = {
      name                = "${var.source_ami_name}"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.al2023"
  ]

  provisioner "file" {
    source = "src"
    destination = "/home/ec2-user"
  }

  provisioner "shell" {
    inline = [
      "ls /home/",
      "echo 'Install packages with dnf'",
      "sudo dnf -y install git bash python3 gcc-c++ cmake",
      "echo 'Setup the hello http service with systemd'",
      "sudo install -Dm 644 /home/ec2-user/src/hello-http-serv@.service /usr/lib/systemd/system/hello-http-serv@.service",
      "echo 'Building code in /home/ec2-user/src/'",
      "cd /home/ec2-user/src",
      "mkdir build-dir",
      "cmake -S . -B build-dir -DCMAKE_INSTALL_PREFIX:PATH=/usr",
      "cmake --build build-dir",
      "sudo cmake --install build-dir",
      "sudo systemctl enable hello-http-serv@5000.service",
    ]
  }
}

variable "my_region" {
  type = string
  default = "us-east-2"
}

variable "source_ami_name" {
  type = string
  default = "al2023-ami-*"
}
