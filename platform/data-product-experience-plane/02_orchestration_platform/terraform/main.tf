locals {
  workspace_servers_annotation = {
    "reloader.stakater.com/search" = "true"
  }
}
module "dagster_control_plane" {
  source = "../../../infrastructure-utility-plane/products/dagster/terraform/aws_instance"

  # Global configuration
  instance_name = local.instance_name

  # Network configuration
  vpc_id                  = data.terraform_remote_state.infrastructure_foundation.outputs.vpc_id
  private_subnet_ids      = data.terraform_remote_state.infrastructure_foundation.outputs.vpc_private_subnets_ids
  allowed_security_groups = [data.terraform_remote_state.infrastructure_foundation.outputs.eks.node_security_group_id]

  # Kubernetes configuration
  eks_cluster_name        = data.terraform_remote_state.infrastructure_foundation.outputs.eks.cluster_name
  eks_cluster_domain_name = data.terraform_remote_state.infrastructure_foundation.outputs.eks_cluster_domain_name
  dagster_namespace       = data.terraform_remote_state.infrastructure_foundation.outputs.platform_data_product_experience_team.namespaces.platform-data-product-experience.metadata[0].name

  # Postgresql configuration
#  postgres_master_username = "dagster"

  # Bucket configuration
  bucket_name_prefix = "data-mesh-dagster"
  celery_worker_queues = [{
    name = "test"
    replicaCount = 3
  }]

  dagster_workspace_servers_configmap_annotations = {
    "reloader.stakater.com/match" = "true"
  }
  daemon_deployment_annotations = local.workspace_servers_annotation
  webserver_deployment_annotations = local.workspace_servers_annotation
}
