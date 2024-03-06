locals {
  flux_crds_path = "${path.module}/files/kubernetes/flux/crds"
}

resource "kubernetes_manifest" "flux_crds" {
  for_each = fileset(local.flux_crds_path, "*.yaml")
  manifest = yamldecode(file("${local.flux_crds_path}/${each.value}"))
  lifecycle {
    ignore_changes = [manifest]
  }
}

resource "helm_release" "flux_controller" {
  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  name             = "flux2"
  namespace        = local.namespace
  create_namespace = false
  version          = "2.10.6"

  values = [
    templatefile(
      "${path.module}/files/kubernetes/flux/flux2-values.yaml",
      {}
    )
  ]


  depends_on = [kubernetes_manifest.flux_crds]
}

resource "helm_release" "tf_controller" {
  repository       = "https://weaveworks.github.io/tf-controller"
  chart            = "tf-controller"
  name             = "tf-controller"
  namespace        = local.namespace
  create_namespace = false
  #  version          = "2.10.6"
  values = [
    templatefile(
      "${path.module}/files/kubernetes/flux/tf-controller-values.yaml",
      {
        serviceAccountSecretName = data.terraform_remote_state.infrastructure_foundation.outputs.platform_infrastructure_team_default_sa
        serviceAccountName       = data.terraform_remote_state.infrastructure_foundation.outputs.platform_infrastructure_team_default_sa
        eventsAddress            = "http://notification-controller.${local.namespace}.svc/"
      }
    )
  ]
  depends_on = [kubernetes_manifest.flux_crds, helm_release.flux_controller]
}