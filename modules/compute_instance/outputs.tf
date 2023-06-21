output "instance_ip" {
  description = "IP address of the Compute Instance"
  value       = google_compute_instance.compute_instance.network_interface[0].access_config[0].nat_ip
}

output "instance_name" {
  description = "Name of the Compute Instance"
  value       = google_compute_instance.compute_instance.name
}

// Add any additional outputs you need
