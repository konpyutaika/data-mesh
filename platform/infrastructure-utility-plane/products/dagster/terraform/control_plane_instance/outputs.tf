output "dagster_workspace_servers_configmap_name" {
  description = "Name of the configmap used by Dagster to retrieve the list of Workspace servers"
  value       = kubernetes_config_map.workspace_servers.metadata[0].name
}

output "dagster_workspace_servers_configmap_namespace" {
  description = "Namespace of the configmap used by Dagster to retrieve the list of Workspace servers"
  value       = kubernetes_config_map.workspace_servers.metadata[0].namespace
}

## Postgresql
output "kubernetes_secret_dagster_postgresql" {
  description = "The name of the kubernetes secret containing the postgresql credentials"
  value       = local.kubernetes_secret_dagster_postgresql
}

output "kubernetes_secret_dagster_postgresql_data" {
  description = "The name of the kubernetes secret containing the postgresql credentials"
  value       = local.kubernetes_secret_dagster_postgresql_data
}

output "kubernetes_configmap_dagster_postgresql" {
  description = "The name of the kubernetes configmap containing the postgresql credentials"
  value       = local.kubernetes_configmap_dagster_postgresql
}

output "kubernetes_configmap_dagster_postgresql_data" {
  description = "The name of the kubernetes configmap containing the postgresql credentials"
  value       = local.kubernetes_configmap_dagster_postgresql_data
}

## S3
output "kubernetes_configmap_object_storage_compute_logs" {
  description = "The name of the kubernetes configmap containing the object storage compute logs config"
  value       = local.kubernetes_configmap_object_storage_compute_logs
}

output "kubernetes_configmap_object_storage_compute_logs_data" {
  description = "The name of the kubernetes configmap containing the object storage compute logs config"
  value       = {
    COMPUTE_LOGS_STORAGE_OBJECT_STORAGE_BUCKET = var.compute_logs.bucket_name
    COMPUTE_LOGS_STORAGE_OBJECT_STORAGE_PREFIX = var.compute_logs.key_prefix
  }
}

# Celery
output "kubernetes_secret_dagster_celery" {
  description = "The name of the kubernetes secret containing the celery configuration"
  value       = local.kubernetes_secret_dagster_celery
}