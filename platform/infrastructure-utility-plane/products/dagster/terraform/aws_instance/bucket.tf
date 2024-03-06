module "dagster_bucket" {
  source      = "../../../aws_helpers/s3_bucket/terraform"
  bucket_name = "${var.bucket_name_prefix}-${var.instance_name}"
}