output "vpc_id" {
  description = "ID of the VPC"
  value       = google_compute_network.network.name
}
