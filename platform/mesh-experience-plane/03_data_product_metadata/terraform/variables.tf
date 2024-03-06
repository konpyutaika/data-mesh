variable "terraform_bucket" {
  type        = string
  description = ""
}

variable "region" {
  type        = string
  description = ""
}

variable "env" {
  type = string
}

variable "ecr_registry" {
  type        = string
  description = "ecr registry"
}

variable "data_foundation_bucket_read_write_policy_arn" {
  type        = string
  description = "data foundation bucket read write policy arn"
}
