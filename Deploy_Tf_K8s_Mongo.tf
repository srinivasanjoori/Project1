resource "kubernetes_deployment" "mongo" {
  metadata {
    name = "mongo"
    labels = {
      app = "mongo"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "mongo"
      }
    }
    template {
      metadata {
        labels = {
          app = "mongo"
        }
      }
      spec {
        container {
          name  = "mongo"
          image = "mongo:latest"
          ports {
            container_port = 27017
          }
          resources {
            limits {
              memory = "256Mi"
              cpu = "500m"
            }
            requests {
              memory = "128Mi"
              cpu = "250m"
            }
          }
          volume_mount {
            name      = "mongodb-data"
            mount_path = "/data/db"
          }
        }
        volume {
          name = "mongodb-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mongodb-data.metadata.0.name
          }
        }
        security_context {
          run_as_user = 999
          fs_group = 999
        }
        readiness_probe {
          exec {
            command = [ "mongo", "--eval", "db.adminCommand('ping')" ]
          }
          initial_delay_seconds = 5
          period_seconds = 10
        }
        liveness_probe {
          exec {
            command = [ "mongo", "--eval", "db.adminCommand('ping')" ]
          }
          initial_delay_seconds = 15
          period_seconds = 20
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "mongodb-data" {
  metadata {
    name = "mongodb-data"
    annotations = {
      "volume.beta.kubernetes.io/storage-class" = "gp2"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "20Gi"
      }
    }
  }
}

resource "kubernetes_service" "mongo" {
  metadata {
    name = "mongo"
    labels = {
      app = "mongo"
    }
  }
  spec {
    selector = {
      app = "mongo"
    }
    ports {
      port = 27017
      target_port = 27017
    }
  }
}

resource "kubernetes_network_policy" "mongo" {
  metadata {
    name = "mongo-network-policy"
  }
  spec {
    pod_selector {
