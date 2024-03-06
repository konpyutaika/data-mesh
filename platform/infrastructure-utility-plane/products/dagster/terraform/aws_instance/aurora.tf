resource "random_password" "password" {
  length      = 16
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  special     = false
}

# TODO: improve this to use a key that is rotated
#tfsec:ignore:aws-kms-auto-rotate-keys
resource "aws_kms_key" "aurora_kms_key" {
  description = "Used to encrypt dagster db."
}

module "aurora_cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "= 8.5.0"

  name           = "${var.instance_name}-dagster"
  engine         = "aurora-postgresql"
  engine_version = "13.8"
  instance_class = "db.t3.medium"
  instances      = {
    primary = {}
  }

  # Network configurations
  vpc_id                 = var.vpc_id
  subnets                = var.private_subnet_ids
  publicly_accessible    = false
  create_db_subnet_group = true

  # Security configurations
  security_group_rules = {
    for security_group_id in var.allowed_security_groups : "${security_group_id}_ingress" =>
    { source_security_group_id = security_group_id }
  }

  # Encryption configurations
  storage_encrypted = true
  kms_key_id        = aws_kms_key.aurora_kms_key.arn

  apply_immediately   = true
  monitoring_interval = 10

  # DB configurations
  db_parameter_group_name         = "default.aurora-postgresql13"
  db_cluster_parameter_group_name = "default.aurora-postgresql13"
  database_name                   = "dagster"

  # Master configuration
  master_username             = var.postgres_master_username
  master_password             = random_password.password.result
  manage_master_user_password = false

  enabled_cloudwatch_logs_exports     = ["postgresql"]
  iam_database_authentication_enabled = true

  deletion_protection       = var.postgres_deletion_protection
  skip_final_snapshot       = var.postgres_skip_final_snapshot
  final_snapshot_identifier = var.postgres_skip_final_snapshot ? var.postgres_final_snapshot_identifier : null
}