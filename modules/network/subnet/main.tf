provider "google" {
  project     = "studidevops-bigpro-fakhri"
  region      = "us-central1"
}
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = var.network_id
}