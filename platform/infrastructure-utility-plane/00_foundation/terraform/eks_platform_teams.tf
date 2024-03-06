module "platform_infrastructure_team" {
  source  = "aws-ia/eks-blueprints-teams/aws"
  version = "= 1.1.0"

  name = "platform-infrastructure"

  users             = concat([], var.platform_infrastructure_additional_users)
  cluster_arn       = module.eks.cluster_arn
  oidc_provider_arn = module.eks.oidc_provider_arn


  namespaces = {
    platform-infrastructure = {
      labels = {
        team = "platform-infrastructure"
      }
      service_account = {
        create_token = true
      }
    }
  }

  depends_on = [module.eks]
}

module "platform_data_product_experience_team" {
  source  = "aws-ia/eks-blueprints-teams/aws"
  version = "= 1.1.0"

  name = "platform-data-product-experience"

  users             = concat([], var.platform_data_product_experience_additional_users)
  cluster_arn       = module.eks.cluster_arn
  oidc_provider_arn = module.eks.oidc_provider_arn

  namespaces = {
    platform-data-product-experience = {
      labels = {
        team = "platform-data-product-experience"
      }
      service_account = {
        create_token = true
      }
    }
  }

  depends_on = [module.eks]
}

module "platform_mesh_experience_team" {
  source  = "aws-ia/eks-blueprints-teams/aws"
  version = "= 1.1.0"

  name = "platform-mesh-experience"

  users             = concat([], var.platform_mesh_experience_additional_users)
  cluster_arn       = module.eks.cluster_arn
  oidc_provider_arn = module.eks.oidc_provider_arn

  namespaces = {
    platform-mesh-experience = {
      labels = {
        team = "platform-mesh-experience"
      }
      service_account = {
        create_token = true
      }
    }
  }

  depends_on = [module.eks]
}