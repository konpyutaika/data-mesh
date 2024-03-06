output "kubernetes_secret_dagster_postgresql_name" {
  value = kubernetes_secret.dagster_postgresql.metadata[0].name
}