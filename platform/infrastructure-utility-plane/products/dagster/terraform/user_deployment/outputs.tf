output "code_location_server_config" {
  description = "Code location server configuration"
  value       = {
    host = local.user_deployment_host
    port = var.code_location_deployment_port
    name = var.code_location_server_name
  }
}