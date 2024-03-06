module "kubernetes_namespace_integration" {
  source        = "../kubernetes_namespace_integration"
  instance_name = var.instance_name

  kubernetes_configmap_dagster_postgresql_data = var.kubernetes_configmap_object_storage_compute_logs_data
  kubernetes_configmap_dagster_postgresql_name = var.kubernetes_configmap_dagster_postgresql_name

  kubernetes_configmap_object_storage_compute_logs_data = var.kubernetes_configmap_object_storage_compute_logs_data
  kubernetes_configmap_object_storage_compute_logs_name = var.kubernetes_configmap_object_storage_compute_logs_name

  kubernetes_namespace = var.kubernetes_namespace

  kubernetes_secret_dagster_postgresql_data = var.kubernetes_secret_dagster_postgresql_data
  kubernetes_secret_dagster_postgresql_name = var.kubernetes_secret_dagster_postgresql_name

  kubernetes_service_account_dagster_name      = var.kubernetes_service_account_dagster_name
  kubernetes_service_account_dagster_namespace = var.kubernetes_service_account_dagster_namespace
}

resource "aws_iam_role_policy_attachment" "s3_compute_logs" {
  role       = var.kubernetes_service_account_aws_iam_role_name
  policy_arn = var.s3_bucket_compute_logs_access_policy_arn
}
