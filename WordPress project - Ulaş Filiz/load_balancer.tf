resource "kubernetes_service" "lb" {
  wait_for_load_balancer = true
  metadata {
    name = "wordress"
  }
  spec {
    selector = {
      
      App = "frontend"
      
    }
    port {
      port        = 80
      target_port = 80
      protocol = "TCP"
    }
    type = "LoadBalancer"
  } 
}

resource "kubernetes_ingress_v1" "example" {
  wait_for_load_balancer = true
  metadata {
    name = "example"
  }
  spec {
    ingress_class_name = "wordpress"
    rule {
      http {
        path {
          path = "/*"
          backend {
            service {
              name = kubernetes_service.lb.metadata.0.name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

output "load_balancer_ip" {
  value = kubernetes_ingress_v1.example.status[0].load_balancer[0].ingress[0].ip
  description = "Deployment Wordpress IP"
}