locals {
  user_deployment_code_cmd = var.code_location_server_python_package_name != null ? [
    "--package-name", var.code_location_server_python_package_name
  ] : (
  var.code_location_server_python_package_name != null ? [
    "--python-file", var.code_location_server_python_file_path
  ] : []
  )
  user_deployment_config = {
    name  = var.code_location_server_name
    image = {
      repository = var.code_location_deployment_image.repository
      tag        = var.code_location_deployment_image.tag
      pullPolicy = "Always"
    }

    # https://github.com/dagster-io/dagster/discussions/14709
    codeServerArgs              = local.user_deployment_code_cmd
    port                        = var.code_location_deployment_port
    resources                   = var.code_location_deployment_resources
    envConfigMaps               = var.code_location_deployment_env_config_maps
    envSecrets                  = var.code_location_deployment_env_secrets
    includeConfigInLaunchedRuns = {
      enabled = true
    }
    annotations = var.code_location_deployment_annotations
  }

  user_deployment_host = "${var.code_location_server_name}.${var.kubernetes_namespace}"
}