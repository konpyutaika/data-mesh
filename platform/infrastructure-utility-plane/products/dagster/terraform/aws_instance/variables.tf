# Global configuration
variable "instance_name" {
  description = "The name of the Dagster instance"
  type        = string
  default     = "dagster"
}

# Network configuration
variable "vpc_id" {
  type        = string
  description = "Id of the VPC where to create resources"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnets IDs used"
}

variable "allowed_security_groups" {
  type        = list(string)
  description = "List of security group allowed as ingress on the aurora"
  default     = []
}

# Kubernetes configuration
variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "eks_cluster_domain_name" {
  type        = string
  description = "EKS cluster domain name"
}

variable "dagster_namespace" {
  description = "The kubernetes namespace to use for the Dagster resources"
  type        = string
}

variable "daemon_deployment_annotations" {
  description = "The annotations to apply to the daemon deployment"
  type        = map(string)
  default     = {}
}

variable "webserver_deployment_annotations" {
  description = "The annotations to apply to the webserver deployment"
  type        = map(string)
  default     = {}
}

variable "dagster_workspace_servers_configmap_annotations" {
  description = "The annotations that will be added to the created dagster workspace servers configmap"
  type = map(string)
  default = {}
}

# Postgresql configuration
variable "postgres_master_username" {
  type        = string
  description = "Username of the master user for the postgresql database"
  default     = "dagster"
}

variable "postgres_deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for the postgresql database"
  default     = false
}

variable "postgres_skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final snapshot for the postgresql database"
  default     = false
}

variable "postgres_final_snapshot_identifier" {
  type        = string
  description = "The name of the final snapshot for the postgresql database"
  default     = ""
}

# Bucket configuration
variable "bucket_name_prefix" {
  description = "The prefix used for the bucket name (suffix will be the instance name)"
  type        = string
}

# Dagster configuration
variable "dagster_version" {
  description = "The version of Dagster to use"
  type        = string
  default     = "1.6.8"
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