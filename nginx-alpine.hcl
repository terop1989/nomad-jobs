job "nginx-job" {

  datacenters = ["dc1"]
  type = "service"

  group "frontend" {

    count = 1

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

      template {
        data = <<EOH
        "{{ key "front_page_template" }}"
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