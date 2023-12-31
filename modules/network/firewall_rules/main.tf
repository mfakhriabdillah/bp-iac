provider "google" {
  project     = "studidevops-bigpro-fakhri"
  region      = "us-central1"
}
resource "google_compute_firewall" "rules" {
  project     = var.project_id
  name        = var.firewall_rule_id
  network     = var.network_id
  description = "Creates firewall rule targeting tagged instances"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol  = "tcp"
    ports     = var.ports_allow
  }

  target_tags = var.target_tags_id
}