data "terraform_remote_state" "infrastructure_foundation" {
  backend = "s3"
  config = {
    bucket = var.terraform_bucket
    key    = "data-mesh/infrastructure-foundation"
    region = var.region
  }
}