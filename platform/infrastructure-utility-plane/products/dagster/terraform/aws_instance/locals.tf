# EKS cluster
locals {
  partition             = data.aws_partition.current.partition
  account_id            = data.aws_caller_identity.current.account_id
  eks_oidc_issuer_url   = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
  eks_oidc_provider_arn = "arn:${local.partition}:iam::${local.account_id}:oidc-provider/${local.eks_oidc_issuer_url}"
}

# Dagster instance
locals {
  dagster_ksa_name              = "${var.instance_name}-dagster"
  dagster_compute_logs_s3_prefix = "dagster-logs"
}