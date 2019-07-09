# ---------------------------------------------------------------------------------------------------------------------
# The code in this example uses 0.12 syntax
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# Deploy TFE Instance
# ---------------------------------------------------------------------------------------------------------------------

# Workaround for https://github.com/terraform-providers/terraform-provider-google/issues/3987
locals {
  network_uri = "https://www.googleapis.com/compute/v1/projects/${var.gcp_project}/global/networks/${var.tfe_instance_network}"
}

resource "google_compute_instance" "tfe" {
  name = var.tfe_instance_name

  machine_type = var.tfe_machine_type
  zone         = var.tfe_instance_zone

  metadata = {
    sshKeys = "${var.tfe_instance_ssh_username}:${var.tfe_instance_ssh_pub_key}"
  }

  metadata_startup_script = "echo 'TFE install script will go here' > test.txt"

  boot_disk {
    initialize_params {
      image = var.tfe_instance_image
      size  = var.tfe_instance_boot_disk_size
    }
  }

  network_interface {
    # network = var.tfe_instance_network
    network = local.network_uri

    access_config {
      # Ephemeral IP
    }
  }

  tags = var.tfe_instance_tags
}

# ---------------------------------------------------------------------------------------------------------------------
# Configure GCP Firewall Rules
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "tfe_ingress" {
  name = "${google_compute_instance.tfe.name}-ingress"

  network = google_compute_instance.tfe.network_interface[0].network

  direction   = "INGRESS"
  target_tags = google_compute_instance.tfe.tags

  allow {
    protocol = "tcp"
    ports    = var.tfe_firewall_ingress_ports
  }
}