terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "fedora_builder" {
  name = "fedora_builder"
  build {
    context = "."
  }
}

resource "docker_container" "dummy_server" {
  image = docker_image.fedora_builder.image_id
  name = "dummy_server"

  ports {
    internal = "12344"
    external = "12344"
  }
}
