# Postgres
locals {
  kubernetes_secret_dagster_postgresql   = "dagster-scoped-${var.instance_name}-postgresql"
}

# S3
locals {
  kubernetes_configmap_object_storage_compute_logs = "dagster-${var.instance_name}-object-storage-compute-logs"
}