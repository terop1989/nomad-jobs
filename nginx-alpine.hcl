job "nginx-job" {

  datacenters = ["dc1"]
  type = "service"

  group "frontend" {

    count = 1

    volume "test" {
      type = "csi"
      source = "test"
      access_mode = "single-node-writer"
      attachment_mode = "file-system"
    }

    task "nginx-task" {
      driver = "docker"
      config {
        image = "nginx:latest"
        mount {
          type = "bind"
          source = "local"
          target = "/usr/share/nginx/html"
        }
      }

      volume_mount {
        volume = "test"
        destination = "/mnt/test"
      }

      template {
        data = <<EOH
        {{ key "front_page_template" }}
        EOH
        destination = "/local/index.html"
      }

      resources {
        cpu = 100
        memory = 256

        network {
          port "http-nginx" {
            static = 80
          }
        }
      }

      service {
        name = "nginx-frontend"
        port = "http-nginx"

        tags = [
          "frontend"
        ]

        check {
          type = "http"
          path = "/"
          interval = "5s"
          timeout = "2s"
        }

      }
    }
  }
}