# Kubernetes configuration
resource "kubernetes_config_map" "workspace_servers" {
  metadata {
    name      = "${var.instance_name}-dagster-workspace"
    namespace = var.dagster_namespace
    annotations = var.dagster_workspace_servers_configmap_annotations
  }

  data = {"workspace.yaml" = yamlencode({load_from = []})}

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

resource "kubernetes_secret" "dagster_postgresql" {
  metadata {
    name      = local.kubernetes_secret_dagster_postgresql
    namespace = var.dagster_namespace
  }
  data = local.kubernetes_secret_dagster_postgresql_data

}

resource "kubernetes_config_map" "dagster_postgresql" {
  metadata {
    name      = local.kubernetes_configmap_dagster_postgresql
    namespace = var.dagster_namespace
  }
  data = local.kubernetes_configmap_dagster_postgresql_data
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
          name        = var.service_account_name
          annotations = var.service_account_annotations
        }

        postgresql_config = {
          host        = var.postgresql_config.host
          port        = var.postgresql_config.port
          database    = var.postgresql_config.database
          username    = var.postgresql_config.username
          password    = var.postgresql_config.password
          secret_name = kubernetes_secret.dagster_postgresql.metadata[0].name
        }
        kubernetes_secret_dagster_celery = local.kubernetes_secret_dagster_celery

        compute_logs = var.compute_logs

        workspace_servers_external_configmap = kubernetes_config_map.workspace_servers.metadata[0].name
        webserver_annotations                = { annotations = var.webserver_deployment_annotations }
        daemon_annotations                   = { annotations = var.daemon_deployment_annotations }
        webserver_service_annotations        = { annotations = var.webserver_service_annotations }
        tag_concurrency_limits               = { tagConcurrencyLimits = [] }

        celery_worker_queues = {
          workerQueues = concat([
            {
              name                 = "dagster"
              replicaCount         = 2
              labels               = {}
              nodeSelector         = {}
              configSource         = {}
              additionalCeleryArgs = []
            }
          ], var.celery_worker_queues)
        }
        redis_config = var.redis_config
      }
    )
  ]
}