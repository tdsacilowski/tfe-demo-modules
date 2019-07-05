module "tfe_demo" {
  source = "../../"

  gcp_project              = var.gcp_project
  tfe_instance_image       = var.tfe_instance_image
  tfe_instance_ssh_pub_key = var.tfe_instance_ssh_pub_key
}