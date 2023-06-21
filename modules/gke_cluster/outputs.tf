output "cluster_name" {
  description = "Name of the GKE cluster"
  value       = google_container_cluster.gke_cluster.name
}