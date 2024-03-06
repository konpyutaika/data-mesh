resource "aws_route53_zone" "zones" {
  name = var.route53_zone_name
  vpc {
    vpc_id     = data.aws_vpc.main.id
    vpc_region = data.aws_region.current.name
  }
  dynamic "vpc" {
    for_each = data.aws_vpc.allowed_vpcs
    content {
      vpc_id     = vpc.value.id
      vpc_region = data.aws_region.current.name
    }
  }
}