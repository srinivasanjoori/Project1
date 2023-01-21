resource "kubernetes_config_map" "mongo" {
  metadata {
    name = "mongo-config"
  }

  data = {
    "mongod.conf" = <<EOF
# MongoDB config file
storage:
  dbPath: "/data/db"
  journal:
    enabled: true
EOF
  }
}

resource "kubernetes_deployment" "mongo" {
  metadata {
    name = "mongo"
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

          volume_mount {
            name      = "config"
            mount_path = "/etc/mongod.conf"
            sub_path  = "mongod.conf"
            read_only = true
          }

          volume_mount {
            name      =
