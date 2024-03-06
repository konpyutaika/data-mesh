# Postgres
locals {
  kubernetes_secret_dagster_postgresql    = "dagster-${var.instance_name}-postgresql"
  kubernetes_configmap_dagster_postgresql = "dagster-${var.instance_name}-postgresql"

  kubernetes_configmap_dagster_postgresql_data = {
    DAGSTER_PG_HOSTNAME = var.postgresql_config.host
    DAGSTER_PG_PORT     = var.postgresql_config.port
    DAGSTER_PG_DB_NAME  = var.postgresql_config.database
    DAGSTER_PG_USERNAME = var.postgresql_config.username
  }
  kubernetes_secret_dagster_postgresql_data = {
    postgresql-password = var.postgresql_config.password
  }
}

# Celery
locals {
  kubernetes_secret_dagster_celery = "dagster-${var.instance_name}-celery-config-secret"
}

# S3
locals {
  kubernetes_configmap_object_storage_compute_logs = "dagster-${var.instance_name}-object-storage-compute-logs"
}