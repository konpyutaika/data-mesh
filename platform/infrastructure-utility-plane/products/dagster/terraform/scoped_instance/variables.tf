# Global configuration
variable "instance_name" {
  description = "The name of the Dagster instance"
  type        = string
  default     = "dagster"
}

variable "is_read_only" {
    description = "Whether the Dagster instance is read only"
    type        = bool
    default     = false
}

variable "dagster_namespace" {
  description = "The kubernetes namespace to use for the Dagster resources"
  type        = string
}

variable "dagster_version" {
  description = "The version of Dagster to use"
  type        = string
  default     = "1.6.8"
}

variable "dagster_workspace_servers_configmap_annotations" {
  description = "The annotations that will be added to the created dagster workspace servers configmap"
  type = map(string)
  default = {}
}

variable "service_account_name" {
  description = "The name of the service account to use for the Dagster resources"
  type        = string
}

# Postgres configuration
variable "postgresql_config" {
  description = "The configuration for the postgresql instance"
  type        = object({
    host     = optional(string)
    username = optional(string)
    password = optional(string)
    database = optional(string)
    port     = optional(number)
  })
  default = {}
}

# S3 configuration
variable "compute_logs" {
  description = "The configuration for the compute logs"
  type        = object({
    type        = string
    bucket_name = optional(string)
    key_prefix  = optional(string)
  })
  default = { type = "S3ComputeLogManager" }
}


# Celery configuration
variable "kubernetes_secret_dagster_celery" {
    description = "The name of the kubernetes secret to use for the celery configuration"
    type        = string
}

variable "kubernetes_secret_dagster_celery_namespace" {
  description = "The namespace of the kubernetes secret to use for the celery configuration"
  type        = string
}


# Webserver configuration
variable "webserver_service_annotations" {
    description = "The annotations to apply to the webserver service"
    type        = map(string)
    default     = {}
}


variable "webserver_deployment_annotations" {
  description = "The annotations to apply to the webserver deployment"
  type        = map(string)
  default     = {}
}
