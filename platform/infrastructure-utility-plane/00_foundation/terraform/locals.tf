locals {
  name = "data-mesh"

  # AWS variable
  region = data.aws_region.current.name

  tags = {
    Blueprint = local.name
    Owner     = "aguitton"
    State     = "experimental"
    Project   = "data-mesh"
    team      = "infrastructure-plane"
  }

  # EKS
  ## Cluster additional security group rules
  cluster_security_group_additional_rules = {
    for key, value in data.aws_vpc.allowed_vpcs :
    value.id => {
      cidr_blocks = [value.cidr_block]
      description = "VPC ${value.tags["Name"]}"
      protocol    = "all"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
    }
  }

  nodes_additional_policies = {
    AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }
}

locals {
  all_namespaces = concat(
    [for key, value in module.platform_infrastructure_team.namespaces : value.metadata[0].name],
    [for key, value in module.platform_data_product_experience_team.namespaces : value.metadata[0].name],
    [for key, value in module.platform_mesh_experience_team.namespaces : value.metadata[0].name],
  )
}