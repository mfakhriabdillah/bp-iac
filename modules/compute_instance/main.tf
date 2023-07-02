provider "google" {
  project     = "studidevops-bigpro-fakhri"
  region      = "us-central1"
}

resource "google_compute_instance" "compute_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network
    subnetwork = var.subnet
    access_config {
      // Set access configuration if needed
    }
  }

  metadata = {
    ssh-keys = var.ssh_pubkey
  }

  desired_status = var.desired_status
  // Add any additional configuration options as needed
}
