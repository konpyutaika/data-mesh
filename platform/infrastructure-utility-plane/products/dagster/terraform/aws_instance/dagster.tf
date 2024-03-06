# TODO: replace IRSA by new method
# IRSA configuration
resource "aws_iam_role" "dagster" {
  name               = "${local.dagster_ksa_name}-sa-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : local.eks_oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${local.eks_oidc_issuer_url}:sub" : "system:serviceaccount:${var.dagster_namespace}:${local.dagster_ksa_name}",
            "${local.eks_oidc_issuer_url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dagster" {
  role       = aws_iam_role.dagster.name
  policy_arn = module.dagster_bucket.read_write_policy_arn
}

module "dagster_instance" {
  source = "../control_plane_instance"

  instance_name = var.instance_name

  dagster_version             = var.dagster_version
  dagster_namespace           = var.dagster_namespace
  service_account_name        = local.dagster_ksa_name
  service_account_annotations = {
    "eks.amazonaws.com/role-arn" = aws_iam_role.dagster.arn
  }

  postgresql_config = {
    host     = module.aurora_cluster.cluster_endpoint
    username = module.aurora_cluster.cluster_master_username
    password = module.aurora_cluster.cluster_master_password
    database = module.aurora_cluster.cluster_database_name
    port     = module.aurora_cluster.cluster_port
  }

  compute_logs = {
    type        = "S3ComputeLogManager"
    bucket_name = module.dagster_bucket.bucket_id
    key_prefix  = local.dagster_compute_logs_s3_prefix
  }

  webserver_service_annotations = {
    "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
    "external-dns.alpha.kubernetes.io/hostname"             = "${var.instance_name}.${var.eks_cluster_domain_name}"
  }

  webserver_deployment_annotations = var.webserver_deployment_annotations
  daemon_deployment_annotations    = var.daemon_deployment_annotations

  dagster_workspace_servers_configmap_annotations = var.dagster_workspace_servers_configmap_annotations

  redis_config = {
    hostname = aws_elasticache_cluster.dagster.cache_nodes[0].address
    port     = aws_elasticache_cluster.dagster.cache_nodes[0].port
  }

  celery_worker_queues = var.celery_worker_queues
}
