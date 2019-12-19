resource "google_compute_network" "vpc" {
# source = "github.com/terraform-google-modules/terraform-google-network"
 name                    = var.network_name
 auto_create_subnetworks = var.auto_create_subnetworks
 project                 = var.project_id
} 
