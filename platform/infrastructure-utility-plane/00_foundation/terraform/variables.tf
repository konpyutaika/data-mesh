variable "region" {
  type        = string
  description = "AWS region"
}

# EKS Network configuration
variable "vpc_tags_selector" {
  type        = map(string)
  description = "Map of tags used to select the VPC"
}

variable "private_subnets_filters" {
  type        = map(list(string))
  description = "List of filters to apply againts the vpc subnets to retrieve the list of private that will be used."
  default = {
    "tag:Name" = ["*-private-*"]
  }
}

variable "vpc_tags_selector_allowed_vpcs" {
  type        = map(map(string))
  description = ""
  default     = {}
}

variable "route53_zone_name" {
  type        = string
  description = "Route 53 zone associated to the cluster and managed by cert manager"
  default     = "data-mesh.com"
}

# Teams configuration
## Platform infrastructure
variable "platform_infrastructure_additional_users" {
  type        = list(string)
  description = "A list of IAM user and/or role ARNs that can assume the IAM role created, for the Platform infrastructure team"
  default     = []
}

variable "platform_data_product_experience_additional_users" {
  type        = list(string)
  description = "A list of IAM user and/or role ARNs that can assume the IAM role created, for the Platform Data Product Experience team"
  default     = []
}

variable "platform_mesh_experience_additional_users" {
  type        = list(string)
  description = "A list of IAM user and/or role ARNs that can assume the IAM role created, for the Platform Mesh Experience team"
  default     = []
}

