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
<html>
<head>
<title>Nomad Task</title>
</head>
<body>
<h1>Welcome to Nomad!</h1>
<p>If you see this page, the task is successfully deployed on host {{ env "attr.unique.hostname" }} and
working. </p>
<p>Service List registered in Nomad Cluster:</p>
{{ range services -}}
<p> # {{ .Name }} </p>
{{- range service .Name }}
<p> {{ .Address }} </p>
{{- end }}
<p></p>
{{ end -}}
</body>
</html>
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