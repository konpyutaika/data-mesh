# Partition (commercial, govCloud, etc) in which to deploy the solution
data "aws_partition" "current" {}

# Find the user currently in use by AWS
data "aws_caller_identity" "current" {}

# Region in which to deploy the solution
data "aws_region" "current" {}

# Availability zones to use in our soultion
data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_vpc" "main" {
  tags = var.vpc_tags_selector
}

data "aws_vpc" "allowed_vpcs" {
  for_each = var.vpc_tags_selector_allowed_vpcs
  tags     = each.value
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  dynamic "filter" {
    for_each = var.private_subnets_filters
    content {
      name   = filter.key
      values = filter.value
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name

}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}