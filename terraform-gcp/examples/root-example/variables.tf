# ---------------------------------------------------------------------------------------------------------------------
# Required Variables
# ---------------------------------------------------------------------------------------------------------------------

variable gcp_project {
  description = "The name of the GCP project into which Terraform will deploy the configured resources."
}

variable tfe_instance_ssh_pub_key {
  description = "The public key for authorized SSH access into the TFE instance."
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional Variables
# ---------------------------------------------------------------------------------------------------------------------

variable "gcp_region" {
  description = "The name of the GCP region into which Terraform will deploy the configured resources."
  default     = "us-east4"
}

variable "tfe_instance_name" {
  description = "The name to apply to the GCP instance onto which TFE will be deployed."
  default     = "tfe"
}

variable "tfe_machine_type" {
  description = "The machine type to use for the TFE instance."
  default     = "n1-standard-4"
}

variable "tfe_instance_zone" {
  description = "The zone within the selected region into which to provision the TFE instance."
  default     = "us-east4-a"
}

variable tfe_instance_image {
  description = "The name of the base machine image to use for the TFE instance."
  default     = "ubuntu-1804-bionic"
}

variable "tfe_instance_boot_disk_size" {
  description = "The size, in GB, to use for the TFE instance boot disk."
  default     = 50
}

variable "tfe_instance_network" {
  description = "The network into which the TFE instance will be provisioned."
  default     = "default"
}

variable tfe_instance_ssh_username {
  description = "The name of the admin user that will be used to SSH into the TFE instance."
  default     = "tfe-admin"
}

variable "tfe_instance_tags" {
  description = "The list of tags to apply to the TFE instance."
  type        = "list"
  default     = ["tfe"]
}

variable "tfe_firewall_ingress_ports" {
  description = "The list of ports on the TFE instance on which to allow public ingress traffic."
  type        = "list"
  default     = ["80", "443", "8800"]
}
