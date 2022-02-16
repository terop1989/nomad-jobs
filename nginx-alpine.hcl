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
    }
  }
}