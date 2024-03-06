vpc_tags_selector = {
  Name = "MainVpc"
}

vpc_tags_selector_allowed_vpcs = {
  "vpn" = {
    Name = "VpnMount"
  }
  "main" = {
    Name = "MainVpc"
  }
}