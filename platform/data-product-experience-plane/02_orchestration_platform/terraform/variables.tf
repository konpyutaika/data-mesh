variable "terraform_bucket" {
  type        = string
  description = ""
}

variable "region" {
  type        = string
  description = ""
}

variable "bucket_name" {
  type        = string
  description = "Name of the bucket that will be used by Dagster (for logs)"
}

variable "env" {
  type = string
}
