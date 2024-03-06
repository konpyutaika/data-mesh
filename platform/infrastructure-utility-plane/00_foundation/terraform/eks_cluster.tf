module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "~> 1.5"

  aliases               = ["eks/${local.name}"]
  description           = "${local.name} EKS cluster encryption key"
  enable_default_policy = true
  key_owners            = [data.aws_caller_identity.current.arn]

  tags = local.tags
}


module  "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "= 19.21.0"

  # Cluster configuration
  cluster_name    = local.name
  cluster_version = "1.28"

  # External encryption key
  create_kms_key            = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms.key_arn
  }

  # Network configuration
  vpc_id                          = data.aws_vpc.main.id
  subnet_ids                      = data.aws_subnets.private.ids
  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  cluster_security_group_additional_rules = local.cluster_security_group_additional_rules
  # OIDC Identity provider
  cluster_identity_providers              = {
    sts = {
      client_id = "sts.amazonaws.com"
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true
  create_aws_auth_configmap = true
  cluster_addons            = {
    coredns = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }

  #  cluster_enabled_log_types = ["api", "audit", "authenticator"]
  eks_managed_node_groups = {
    common = {
      instance_types               = ["m5.xlarge"]
      iam_role_additional_policies = local.nodes_additional_policies

      min_size     = 1
      max_size     = 5
      desired_size = 4
    }
  }

  aws_auth_users = [
    {
      userarn  = data.aws_caller_identity.current.arn
      username = "admin"
      groups   = ["system:masters"]
    },
  ]
}