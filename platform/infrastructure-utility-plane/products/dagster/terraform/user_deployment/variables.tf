# Dagster configuration
variable "dagster_version" {
  description = "The version of Dagster to use"
  type        = string
  default     = "1.6.8"
}

# Kubernetes configuration
variable "kubernetes_namespace" {
  description = "The namespace to deploy the application to"
  type        = string
}

variable "kubernetes_service_account_name" {
  description = "The name of the service account to use for the application"
  type        = string
}

variable "kubernetes_secret_dagster_postgresql_name" {
  description = "The name of the kubernetes secret containing the Dagster Postgres connection data"
  type        = string
}

# Code location server deployment configuration
variable "code_location_deployment_port" {
  description = "The port the code location server deployment will listen on"
  type        = number
  default     = 3030
}


variable "code_location_deployment_image" {
  description = "The image to use for the code location server deployment"
  type        = object({
    repository = string
    tag        = string
  })
}

variable "code_location_deployment_env_config_maps" {
  description = "The config maps to use for the code location server deployment as environment variables"
  type        = list(string)
  default     = []
}

variable "code_location_deployment_env_secrets" {
  description = "The secrets to use for the code location server deployment as environment variables"
  type        = list(string)
  default     = []
}


variable "code_location_deployment_resources" {
  description = "The resources to allocate to the code location server deployment"
  type        = object({
    limits = object({
      cpu    = string
      memory = string
    }),
    requests = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    limits = {
      cpu    = "250m"
      memory = "500Mi"
    }
    requests = {
      cpu    = "250m"
      memory = "200Mi"
    }
  }
}

variable "code_location_deployment_annotations" {
    description = "The annotations to add to the code location server deployment"
    type        = map(string)
    default     = {}
}

# Code location server configuration
variable "code_location_server_name" {
  description = "The name of the code location server deployment"
  type        = string
}

variable "code_location_server_python_file_path" {
  description = "The path to the python file to run for the code location server"
  type        = string
  default     = null
}

variable "code_location_server_python_package_name" {
  description = "The name of the python package to run the code location server"
  type        = string
  default     = null
}