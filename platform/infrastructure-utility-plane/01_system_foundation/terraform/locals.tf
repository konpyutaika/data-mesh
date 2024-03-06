locals {
  namespace = data.terraform_remote_state.infrastructure_foundation.outputs.platform_infrastructure_team.namespaces.platform-infrastructure.metadata[0].name
}
