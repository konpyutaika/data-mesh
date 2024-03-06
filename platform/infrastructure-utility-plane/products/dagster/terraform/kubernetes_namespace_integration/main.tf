#TODO: Add read-only / limited dagster webserver ?
resource "kubernetes_secret" "dagster_postgresql" {
  metadata {
    name      = var.kubernetes_secret_dagster_postgresql_name
    namespace = var.kubernetes_namespace
  }
  data = var.kubernetes_secret_dagster_postgresql_data

}

resource "kubernetes_config_map" "dagster_postgresql" {
  metadata {
    name      = var.kubernetes_configmap_dagster_postgresql_name
    namespace = var.kubernetes_namespace
  }
  data = var.kubernetes_configmap_dagster_postgresql_data
}

resource "kubernetes_config_map" "dagster_compute_logs_object_storage" {
  metadata {
    name      = var.kubernetes_configmap_object_storage_compute_logs_name
    namespace = var.kubernetes_namespace
  }
  data = var.kubernetes_configmap_object_storage_compute_logs_data
}

resource "kubernetes_role" "dagster" {
  metadata {
    name      = "dagster-${var.instance_name}-role"
    namespace = var.kubernetes_namespace
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs", "jobs/status"]
    verbs      = ["*"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/log", "pods/status"]
    verbs      = ["*"]
  }
}

resource "kubernetes_role_binding" "dagster" {
  metadata {
    name      = "dagster-${var.instance_name}"
    namespace = var.kubernetes_namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.dagster.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.kubernetes_service_account_dagster_name
    namespace = var.kubernetes_service_account_dagster_namespace
  }
}