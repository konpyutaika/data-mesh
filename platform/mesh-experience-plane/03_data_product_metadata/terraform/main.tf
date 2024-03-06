module "namespace_integration" {
  source = "../../../infrastructure-utility-plane/products/dagster/terraform/aws_kubernetes_namespace_integration"

  instance_name        = local.instance_name
  kubernetes_namespace = data.terraform_remote_state.infrastructure_foundation.outputs.platform_mesh_experience_team.namespaces.platform-mesh-experience.metadata[0].name

  kubernetes_configmap_dagster_postgresql_data = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.kubernetes_configmap_dagster_postgresql_data
  kubernetes_configmap_dagster_postgresql_name = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.kubernetes_configmap_dagster_postgresql_name

  kubernetes_configmap_object_storage_compute_logs_data = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.kubernetes_configmap_object_storage_compute_logs_data
  kubernetes_configmap_object_storage_compute_logs_name = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.kubernetes_configmap_object_storage_compute_logs_name

  kubernetes_secret_dagster_postgresql_data = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.kubernetes_secret_dagster_postgresql_data
  kubernetes_secret_dagster_postgresql_name = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.kubernetes_secret_dagster_postgresql_name

  kubernetes_service_account_aws_iam_role_name = data.terraform_remote_state.infrastructure_foundation.outputs.platform_mesh_experience_team.iam_role_name
  kubernetes_service_account_dagster_name      = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.dagster_kubernetes_service_account
  kubernetes_service_account_dagster_namespace = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.dagster_namespace

  s3_bucket_compute_logs_access_policy_arn = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.dagster_compute_logs_s3_read_write_policy_arn
}

# TODO: move to user code deployment requirement
resource "aws_iam_role_policy_attachment" "data_foundation_bucket" {
  role       = data.terraform_remote_state.infrastructure_foundation.outputs.platform_mesh_experience_team.iam_role_name
  policy_arn = var.data_foundation_bucket_read_write_policy_arn
}

resource "aws_iam_role_policy_attachment" "dynamodb" {
  role       = data.terraform_remote_state.infrastructure_foundation.outputs.platform_mesh_experience_team.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
}


module "redshift_tables_external_assets" {
  source = "../../../infrastructure-utility-plane/products/dagster/terraform/user_deployment"

  code_location_server_name      = "redshift-external-tables"
  code_location_deployment_image = {
    repository = "${var.ecr_registry}/dagster_dtms_triggered"
    tag        = "external_assets"
  }
  dagster_version = "1.6.8"

  kubernetes_namespace                      = data.terraform_remote_state.infrastructure_foundation.outputs.platform_mesh_experience_team.namespaces.platform-mesh-experience.metadata[0].name
  kubernetes_secret_dagster_postgresql_name = module.namespace_integration.kubernetes_secret_dagster_postgresql_name
  kubernetes_service_account_name           = data.terraform_remote_state.infrastructure_foundation.outputs.platform_mesh_experience_team_sa

  code_location_server_python_package_name = "data_product_metadata"
}