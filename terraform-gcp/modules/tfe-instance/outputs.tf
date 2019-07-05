output "tfe_instance_public_ip" {
  description = "The publically-accessible IP address for the TFE instance."
  value       = google_compute_instance.tfe.network_interface[0].access_config[0].nat_ip
}
