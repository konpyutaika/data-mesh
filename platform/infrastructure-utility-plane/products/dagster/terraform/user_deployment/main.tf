resource "helm_release" "dagster_user_deployment" {
  name       = var.code_location_server_name
  repository = "https://dagster-io.github.io/helm"
  chart      = "dagster-user-deployments"
  namespace  = var.kubernetes_namespace
  version    = var.dagster_version
  values     = [
    templatefile(
      "${path.module}/files/user_deployment.yaml",
      {
        ksa_name                         = var.kubernetes_service_account_name
        postgresql_secret_name           = var.kubernetes_secret_dagster_postgresql_name
        deployments                      = {
          deployments = [local.user_deployment_config]
        }

      }
    )
  ]
}