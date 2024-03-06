# Global configuration
variable "instance_name" {
  description = "The name of the Dagster instance"
  type        = string
  default     = "dagster"
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

variable "service_account_annotations" {
  description = "The annotations to apply to the service account"
  type        = map(string)
  default     = {}
}

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

variable "compute_logs" {
  description = "The configuration for the compute logs"
  type        = object({
    type        = string
    bucket_name = optional(string)
    key_prefix  = optional(string)
  })
  default = { type = "S3ComputeLogManager" }
}

variable "celery_worker_queues" {
  description = "The queues to use for the celery workers"
  type        = list(
    object({
      name                 = string
      replicaCount         = number
      labels               = optional(map(string))
      nodeSelector         = optional(map(string))
      configSource         = optional(map(string))
      additionalCeleryArgs = optional(list(string))
    })
  )
  default = []
}

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

variable "daemon_deployment_annotations" {
  description = "The annotations to apply to the daemon deployment"
  type        = map(string)
  default     = {}
}

variable "redis_config" {
  description = "The configuration for the redis instance"
  type        = object({
    hostname = string
    port     = optional(number)
  })
}