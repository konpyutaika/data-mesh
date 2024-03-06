output "dagster_namespace" {
  value       = module.dagster_control_plane.dagster_namespace
  description = "The namespace of the Dagster control plane"
}

output "dagster_kubernetes_service_account" {
  value       = module.dagster_control_plane.dagster_kubernetes_service_account
  description = "The name of the ServiceAccount for the Dagster control plane"
}

output "dagster_workspace_servers_configmap_name" {
  value       = module.dagster_control_plane.dagster_workspace_servers_configmap_name
  description = "The name of the ConfigMap containing the workspace servers configuration"
}

output "dagster_workspace_servers_configmap_namespace" {
  value       = module.dagster_control_plane.dagster_workspace_servers_configmap_namespace
  description = "The namespace of the ConfigMap containing the workspace servers configuration"
}

output "kubernetes_configmap_dagster_postgresql_data" {
  value       = module.dagster_control_plane.kubernetes_configmap_dagster_postgresql_data
  description = "The data of the ConfigMap containing the Dagster Postgres configuration"
  sensitive   = true   # TODO: improved using a secret manager (e.g Hashicorp Vault) or when swith on tf-controller
}

output "kubernetes_configmap_dagster_postgresql_name" {
  value       = module.dagster_control_plane.kubernetes_configmap_dagster_postgresql
  description = "The name of the ConfigMap containing the Dagster Postgres configuration"
}

output "kubernetes_configmap_object_storage_compute_logs_data" {
  value       = module.dagster_control_plane.kubernetes_configmap_object_storage_compute_logs_data
  description = "The data of the ConfigMap containing the compute logs S3 configuration"
}

output "kubernetes_configmap_object_storage_compute_logs_name" {
  value       = module.dagster_control_plane.kubernetes_configmap_object_storage_compute_logs
  description = "The name of the ConfigMap containing the compute logs S3 configuration"
}

output "kubernetes_secret_dagster_postgresql_data" {
  value       = module.dagster_control_plane.kubernetes_secret_dagster_postgresql_data
  description = "The data of the Secret containing the Dagster Postgres credentials"
  sensitive   = true   # TODO: improved using a secret manager (e.g Hashicorp Vault) or when swith on tf-controller
}

output "kubernetes_secret_dagster_postgresql_name" {
  value       = module.dagster_control_plane.kubernetes_secret_dagster_postgresql
  description = "The name of the Secret containing the Dagster Postgres credentials"
}

output "kubernetes_service_account_dagster_name" {
  value       = module.dagster_control_plane.dagster_kubernetes_service_account
  description = "The name of the ServiceAccount for the Dagster control plane"
}

output "kubernetes_service_account_dagster_namespace" {
  value       = module.dagster_control_plane.dagster_namespace
  description = "The namespace of the ServiceAccount for the Dagster control plane"
}

output "dagster_compute_logs_s3_read_write_policy_arn" {
  value       = module.dagster_control_plane.dagster_compute_logs_s3.read_write_policy_arn
  description = "The ARN of the access policy for the compute logs S3 bucket"
}