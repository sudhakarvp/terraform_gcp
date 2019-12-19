resource "google_compute_subnetwork" "subnet-public" {
 name          = "${var.name}"
 ip_cidr_range = "${var.subnet_cidr_public}"
 network       = "var.network_name"
 region      = "var.region"
} 
