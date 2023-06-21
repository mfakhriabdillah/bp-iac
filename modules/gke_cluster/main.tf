resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region

  # Define additional cluster configuration here

  node_pool {
    name       = var.node_pool_name
    machine_type = var.machine_type
    initial_node_count = var.initial_node_count
  }
}
