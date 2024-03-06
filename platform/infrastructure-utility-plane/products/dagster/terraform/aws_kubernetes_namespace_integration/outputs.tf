# Postgres
output "kubernetes_secret_dagster_postgresql_name" {
    value = module.kubernetes_namespace_integration.kubernetes_secret_dagster_postgresql_name
}