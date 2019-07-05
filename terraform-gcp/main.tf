# ---------------------------------------------------------------------------------------------------------------------
# The code in this example uses 0.12 syntax
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# Configure the GCP Provider
#
# In order to avoid accidentally commiting credentials into version control, it's typically safer
# to set provider credentials using the appropriate environment variable(s).
#
# For GCP, this var would be "GOOGLE_CREDENTIALS".
#
# For TF OSS this can be set to the path to your credentials file on the local file system.
#
# For TFE/TF Cloud (where you can't directly provide a credentials file),
# it can be set to the contents of your credentials file.
#
# Note that for this latter approach, the JSON contents of the
# credentials file needs to be converted into a single string, e.g:
# `cat CREDENTIALS_FILE.json | jq -c`
# ---------------------------------------------------------------------------------------------------------------------


provider "google" {
  # credentials = "${file("CREDENTIALS_FILE.json")}"
  project = var.gcp_project
  region  = var.gcp_region
}

# ---------------------------------------------------------------------------------------------------------------------
# Provision the TFE Instance
# ---------------------------------------------------------------------------------------------------------------------

module "tfe_instance" {
  source = "./modules/tfe-instance"

  gcp_project              = var.gcp_project
  tfe_instance_image       = var.tfe_instance_image
  tfe_instance_ssh_pub_key = var.tfe_instance_ssh_pub_key
}

# ---------------------------------------------------------------------------------------------------------------------
# Provision GCP Load Balancer Resources for the TFE Instance
# ---------------------------------------------------------------------------------------------------------------------

/*
module "tfe_load_balancer" {
  source = "./modules/tfe-load-balancer"
}
*/