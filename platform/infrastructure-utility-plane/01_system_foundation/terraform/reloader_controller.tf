resource "helm_release" "reload_controller" {
  repository       = "https://stakater.github.io/stakater-charts"
  chart            = "reloader"
  name             = "reloader"
  namespace        = local.namespace
  create_namespace = false
  version          = "1.0.63"

  values = [
    templatefile(
      "${path.module}/files/kubernetes/reloader/values.yaml",
      {}
    )
  ]


  depends_on = [kubernetes_manifest.flux_crds]
}
