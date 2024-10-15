terraform {
    required_providers {
        docker = {
            source= "kreuzwerker/docker",
            version = "3.0.2"
        }
    }
}

provider "docker" {}

resource "docker_image" "watchtower" {
    name         = "containrrr/watchtower:latest"
    keep_locally = true
}

resource "docker_container" "watchtower" {
  name    = "watchtower"
  image   = docker_image.watchtower.name
  restart = "always"

  volumes {
    container_path = "/var/run/docker.sock"
    host_path      = "/var/run/docker.sock"
    read_only      = false
  }

  volumes {
    container_path = "/etc/localtime"
    host_path      = "/etc/localtime"
    read_only      = true
  }

  env = [
    "COM_CENTURYLINKLABS_WATCHTOWER_ENABLE=true"
  ]

  command = ["--label-enable", "--cleanup", "--schedule", "0 15 4 * * *"]

  memory = 32 * 1024 * 1024 // 32M
}