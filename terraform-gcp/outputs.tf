output "tfe_instance_public_ip" {
  description = "The publicly-accessible IP address for the TFE instance."
  value       = module.tfe_instance.tfe_instance_public_ip
}
