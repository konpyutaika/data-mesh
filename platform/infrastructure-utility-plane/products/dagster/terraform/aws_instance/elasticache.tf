resource "aws_security_group" "dagster_elasticache" {
  name        = "${var.instance_name}-dagster-elasticache"
  vpc_id      = var.vpc_id
  description = "Security Group attached to Dagster Elasticache"
}

resource "aws_elasticache_subnet_group" "dagster" {
  name       = "${var.instance_name}-dagster-elasticache"
  subnet_ids = var.private_subnet_ids
}

# TODO: review this in the modul
resource "aws_elasticache_cluster" "dagster" {
  cluster_id           = "${var.instance_name}-dagster"
  apply_immediately = true

  engine               = "redis"
  engine_version       = "7.0"
  # TODO: make it configurable
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  # tflint-ignore: aws_elasticache_cluster_default_parameter_group
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.dagster.name
  security_group_ids   = [aws_security_group.dagster_elasticache.id]

  snapshot_retention_limit = 1
  snapshot_window          = "00:00-05:00"
}

resource "aws_security_group_rule" "allow_redis_from" {
  count = length(var.allowed_security_groups)

  type      = "ingress"
  from_port = 6379
  to_port   = 6379
  protocol  = "tcp"

  source_security_group_id = var.allowed_security_groups[count.index]
  security_group_id        = aws_security_group.dagster_elasticache.id

  description = "Allow Redis access from ${var.allowed_security_groups[count.index]}"
}