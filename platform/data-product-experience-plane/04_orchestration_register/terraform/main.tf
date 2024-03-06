# TODO: move to 03_orchestration_register
locals {
  servers = [
    data.terraform_remote_state.data_product_metadata.outputs.code_location_server_config
  ]
  workspace_servers_data = {"workspace.yaml" = yamlencode({
    load_from = [
      for server in local.servers : {
        grpc_server : {
          host          = server.host
          port          = server.port
          location_name = server.name
        }
      }
    ]
  })}
}

resource "kubernetes_config_map_v1_data" "workspace_servers" {
  force = true
  metadata {
    name      = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.dagster_workspace_servers_configmap_name
    namespace = data.terraform_remote_state.data_product_experience_orchestration_platform.outputs.dagster_workspace_servers_configmap_namespace
  }

  data = local.workspace_servers_data
}