resource "digitalocean_kubernetes_cluster" "k8s" {
  name   = "k8s"
  region = var.region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.25.4-do.0"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 2

  }
}

resource "local_file" "foo" {
  content  = digitalocean_kubernetes_cluster.k8s.kube_config.0.raw_config
  filename = "${path.module}/kube_config.yaml"
}