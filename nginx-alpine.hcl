job "nginx-job" {

  datacenters = ["dc1"]
  type = "service"

  group "frontend" {
    count = 1

    task "nginx-task" {
      driver = "docker"
      config {
        image = "nginx:latest"
      }

      resources {
        network {
          port "http-nginx" {
            static = 8888
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