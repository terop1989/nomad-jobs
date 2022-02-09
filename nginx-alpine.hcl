job "nginx-job" {

  datacenters = ["dc1"]
  type = "service"

  task "nginx-task" {
    driver = "docker"
    config {
      image = "terop1989/nginx-alpine:v1"


    }
  }
}