output "code_location_server_config" {
  value       = module.redshift_tables_external_assets.code_location_server_config
  description = "The server configuration for the code location"
}