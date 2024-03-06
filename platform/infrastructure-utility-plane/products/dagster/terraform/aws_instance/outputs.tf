# Postgresql
output "postgresql_password" {
  description = "The password for the postgresql database"
  value       = module.aurora_cluster.cluster_master_password
}

output "postgresql_hostname" {
  description = "The hostname for the postgresql database"
  value       = module.aurora_cluster.cluster_endpoint
}

output "postgresql_database_name" {
  description = "The database name for the postgresql database"
    value       = module.aurora_cluster.cluster_database_name
}

output "postgresql_username" {
  description = "The username for the postgresql database"
  value       = module.aurora_cluster.cluster_master_username
}

output "postgresql_port" {
  description = "The port for the postgresql database"
  value       = module.aurora_cluster.cluster_port
}

# S3 bucket
output "dagster_compute_logs_s3_bucket" {
  description = "S3 bucket containing S3 logs"
  value       = module.dagster_bucket.bucket_id
}

output "dagster_compute_logs_s3_prefix" {
  description = "S3 prefix path where the Dagster's compute log will be stored"
  value       = local.dagster_compute_logs_s3_prefix
}

output "dagster_compute_logs_s3" {
  description = "S3 module output where the Dagster's compute log will be stored"
  value       = module.dagster_bucket
}

# Kubernetes
output "dagster_kubernetes_service_account" {
  description = "Kubernetes service account name for dagster"
  value       = local.dagster_ksa_name
}

output "dagster_namespace" {
  description = "Namespace used to host Dagster stack"
  value       = var.dagster_namespace
}

##  Workspace servers
output "dagster_workspace_servers_configmap_name" {
  description = "Name of the configmap used by Dagster to retrieve the list of Workspace servers"
  value       = module.dagster_instance.dagster_workspace_servers_configmap_name
}

output "dagster_workspace_servers_configmap_namespace" {
  description = "Namespace of the configmap used by Dagster to retrieve the list of Workspace servers"
  value       = module.dagster_instance.dagster_workspace_servers_configmap_namespace
}

## Postgresql
output "kubernetes_secret_dagster_postgresql" {
  description = "The name of the kubernetes secret containing the postgresql credentials"
  value       = module.dagster_instance.kubernetes_secret_dagster_postgresql
}

output "kubernetes_secret_dagster_postgresql_data" {
  description = "The name of the kubernetes secret containing the postgresql credentials"
  value       = module.dagster_instance.kubernetes_secret_dagster_postgresql_data
}

output "kubernetes_configmap_dagster_postgresql" {
  description = "The name of the kubernetes configmap containing the postgresql credentials"
  value       = module.dagster_instance.kubernetes_configmap_dagster_postgresql
}

output "kubernetes_configmap_dagster_postgresql_data" {
  description = "The name of the kubernetes configmap containing the postgresql credentials"
  value       = module.dagster_instance.kubernetes_configmap_dagster_postgresql_data
}

## S3
output "kubernetes_configmap_object_storage_compute_logs" {
  description = "The name of the kubernetes configmap containing the object storage compute logs config"
  value       = module.dagster_instance.kubernetes_configmap_object_storage_compute_logs
}

output "kubernetes_configmap_object_storage_compute_logs_data" {
  description = "The name of the kubernetes configmap containing the object storage compute logs config"
  value       = module.dagster_instance.kubernetes_configmap_object_storage_compute_logs_data
}

# Celery
output "kubernetes_secret_dagster_celery" {
  description = "The name of the kubernetes secret containing the celery configuration"
  value       = module.dagster_instance.kubernetes_secret_dagster_celery
}