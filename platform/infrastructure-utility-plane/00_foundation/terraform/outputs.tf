output "vpc_id" {
  value       = data.aws_vpc.main.id
  description = "The VPC ID"
}

output "vpc_private_subnets_ids" {
  value       = data.aws_subnets.private.ids
  description = "The private subnets"
}

output "vpc_allowed_vpcs" {
  value       = data.aws_vpc.allowed_vpcs
  description = "The allowed VPCs"
}

output "eks" {
  value       = module.eks
  description = "The EKS cluster"
}

output "eks_cluster_domain_name" {
  value       = aws_route53_zone.zones.name
  description = "The domain name of the Route53 zone"
}

output "platform_infrastructure_team" {
  value = module.platform_infrastructure_team
}

output "platform_infrastructure_team_default_sa" {
  value = module.platform_infrastructure_team.namespaces.platform-infrastructure.metadata[0].name
}

output "platform_data_product_experience_team" {
  value = module.platform_data_product_experience_team
}

output "platform_data_product_experience_team_sa" {
  value = module.platform_data_product_experience_team.namespaces.platform-data-product-experience.metadata[0].name
}

output "platform_mesh_experience_team" {
  value = module.platform_mesh_experience_team
}

output "platform_mesh_experience_team_sa" {
  value = module.platform_mesh_experience_team.namespaces.platform-mesh-experience.metadata[0].name
}

resource "kubernetes_config_map" "infrastructure_foundation" {
  for_each = { for key in local.all_namespaces : key => key }
  metadata {
    name      = "tf-infrastructure-foundation-outputs"
    namespace = each.key
  }
  data = {
    vpc_id                                   = data.aws_vpc.main.id
    vpc_private_subnets_ids                  = yamlencode(data.aws_subnets.private.ids)
    vpc_allowed_vpcs                         = yamlencode(data.aws_vpc.allowed_vpcs)
    eks_cluster_name                         = module.eks.cluster_name
    eks_cluster_domain_name                  = aws_route53_zone.zones.name
    platform_infrastructure_team_default_sa  = module.platform_infrastructure_team.namespaces.platform-infrastructure.metadata[0].name
    platform_data_product_experience_team_sa = module.platform_data_product_experience_team.namespaces.platform-data-product-experience.metadata[0].name
    platform_mesh_experience_team_sa         = module.platform_mesh_experience_team.namespaces.platform-mesh-experience.metadata[0].name
  }
}

resource "kubernetes_secret" "infrastructure_foundation" {
  for_each = { for key in local.all_namespaces : key => key }
  metadata {
    name      = "tf-infrastructure-foundation-outputs"
    namespace = each.key
  }
  data = {
    eks = yamlencode(module.eks)
  }
}