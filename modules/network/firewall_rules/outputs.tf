output "firewall_id" {
  description = "ID of the firewall"
  value       = google_compute_firewall.rules.id
}