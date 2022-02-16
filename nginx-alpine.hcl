job "nginx-job" {

  datacenters = ["dc1"]
  type = "service"

  group "frontend" {
    count = 1

    task "nginx-task" {
      driver = "docker"
      config {
        image = "terop1989/nginx-alpine:v1"
      }
    }
  }
}