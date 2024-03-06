module "ebs_csi_driver_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "= 5.30"

  role_name_prefix = "${local.name}-ebs-csi-driver-"

  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

module "efs_csi_driver_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "= 5.30"

  role_name_prefix = "${local.name}-efs-csi-driver-"

  attach_efs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:efs-csi-controller-sa"]
    }
  }
}

module "eks_blueprint_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "= 1.9.2"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn
    }

    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn
    }
  }

  enable_aws_efs_csi_driver = true
  aws_efs_csi_driver = {
    most_recent              = true
    service_account_role_arn = module.efs_csi_driver_irsa.iam_role_arn
  }
  enable_aws_load_balancer_controller = true
  aws_load_balancer_controller = {
    set = [{
      name  = "enableServiceMutatorWebhook"
      value = "false"
    }]
  }
  enable_argocd         = true
  enable_argo_rollouts  = false
  enable_argo_workflows = false
  enable_argo_events    = false
  #  argocd = {}
  enable_cert_manager       = true
  enable_cluster_autoscaler = true
  enable_metrics_server     = true

  enable_external_dns            = true
  external_dns_route53_zone_arns = [aws_route53_zone.zones.arn]
  external_dns = {
    set_values = [
      {
        name  = "domainFilters[0]",
        value = aws_route53_zone.zones.name
      }
    ]
  }
  depends_on = [module.eks]
}