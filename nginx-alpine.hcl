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

      template {
        data = <<EOH
<html>
<head>
<title>Nomad Task</title>
</head>
<body>
<h1>Welcome to Nomad!</h1>
<p>If you see this page, the task is successfully deployed and
working. </p>
</body>
</html>
        EOH
        destination = "/usr/share/nginx/html/index.html"
        
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