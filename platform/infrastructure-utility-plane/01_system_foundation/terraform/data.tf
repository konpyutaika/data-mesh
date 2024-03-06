data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.infrastructure_foundation.outputs.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.infrastructure_foundation.outputs.eks.cluster_name
}