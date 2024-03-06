data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.infrastructure_foundation.outputs.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.infrastructure_foundation.outputs.eks.cluster_name
}

## Remote state
data "terraform_remote_state" "infrastructure_foundation" {
  backend = "s3"
  config = {
    bucket = var.terraform_bucket
    key    = "data-mesh/infrastructure-foundation"
    region = var.region
  }
}