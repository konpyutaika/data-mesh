variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "kubernetes_service_account_dagster_name" {
  description = "The name of the kubernetes service account for the Dagster resources"
  type        = string
}

variable "kubernetes_service_account_dagster_namespace" {
  description = "The namespace of the kubernetes service account for the Dagster resources"
  type        = string
}

variable "kubernetes_namespace" {
  description = "The kubernetes namespace to use for the Dagster resources"
  type        = string
}

variable "kubernetes_secret_dagster_postgresql_name" {
  description = "The name of the kubernetes secret containing the Dagster Postgres connection data"
  type        = string
}

variable "kubernetes_secret_dagster_postgresql_data" {
  description = "The data in the kubernetes secret containing the Dagster Postgres connection data"
  type        = map(string)
}

variable "kubernetes_configmap_dagster_postgresql_name" {
  description = "The name of the kubernetes configmap containing the Dagster Postgres connection data"
  type        = string
}

variable "kubernetes_configmap_dagster_postgresql_data" {
  description = "The data in the kubernetes configmap containing the Dagster Postgres connection data"
  type        = map(string)
}

variable "kubernetes_configmap_object_storage_compute_logs_name" {
  description = "The name of the kubernetes configmap containing the object storage compute logs configuration"
  type        = string
}

variable "kubernetes_configmap_object_storage_compute_logs_data" {
  description = "The data in the kubernetes configmap containing the object storage compute logs configuration"
  type        = map(string)
}

variable "kubernetes_service_account_aws_iam_role_name" {
    description = "The name of the AWS IAM role for the kubernetes service account"
    type        = string
}

variable "s3_bucket_compute_logs_access_policy_arn" {
    description = "The ARN of the AWS IAM policy for the S3 bucket containing the compute logs"
    type        = string
}