# Kubernetes configuration
resource "kubernetes_config_map" "workspace_servers" {
  metadata {
    name      = "${var.instance_name}-scoped-dagster-workspace"
    namespace = var.dagster_namespace
    annotations = var.dagster_workspace_servers_configmap_annotations
  }

  data = {}

  lifecycle {
    # We are ignoring the data here since we will manage it with the resource below
    # This is only intended to be used in scenarios where the configmap does not exist
    ignore_changes = [data]
  }
}

data "kubernetes_config_map" "workspace_servers" {
  metadata {
    name      = kubernetes_config_map.workspace_servers.metadata[0].name
    namespace = kubernetes_config_map.workspace_servers.metadata[0].namespace
  }
}

# Celery configuration
data "kubernetes_secret" "celery" {
    metadata {
        name      = var.kubernetes_secret_dagster_celery
        namespace = var.kubernetes_secret_dagster_celery_namespace
    }
}

resource "kubernetes_secret" "dagster_celery_config" {
  metadata {
    name      = data.kubernetes_secret.celery.metadata[0].name
    namespace = var.dagster_namespace
  }

  data = data.kubernetes_secret.celery.data
}

resource "helm_release" "dagster" {
  name       = var.instance_name
  repository = "https://dagster-io.github.io/helm"
  chart      = "dagster"
  namespace  = var.dagster_namespace
  version    = var.dagster_version
  values     = [
    templatefile(
      "${path.module}/files/dagster.yaml",
      {
        service_account_config = {
          name = var.service_account_name
        }

        is_read_only = var.is_read_only

        postgresql_config = {
          host        = var.postgresql_config.host
          port        = var.postgresql_config.port
          database    = var.postgresql_config.database
          username    = var.postgresql_config.username
          password    = var.postgresql_config.password
          secret_name = local.kubernetes_secret_dagster_postgresql
        }
        kubernetes_secret_dagster_celery = var.kubernetes_secret_dagster_celery

        compute_logs = var.compute_logs

        workspace_servers_external_configmap = kubernetes_config_map.workspace_servers.metadata[0].name
        webserver_annotations                = { annotations = var.webserver_deployment_annotations }
        webserver_service_annotations        = { annotations = var.webserver_service_annotations }
      }
    )
  ]
}