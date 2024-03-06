output "dagster_workspace_servers_configmap_name" {
  description = "Name of the configmap used by Dagster to retrieve the list of Workspace servers"
  value       = kubernetes_config_map.workspace_servers.metadata[0].name
}

output "dagster_workspace_servers_configmap_namespace" {
  description = "Namespace of the configmap used by Dagster to retrieve the list of Workspace servers"
  value       = kubernetes_config_map.workspace_servers.metadata[0].namespace
}