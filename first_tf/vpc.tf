# Create firewall rule
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  source_tags = ["web"]
}

# Create VPC network
resource "google_compute_network" "vpc_network" {
  name = "vpc-network-aut"
  auto_create_subnetworks = false
}

# Create Public subnet
resource "google_compute_subnetwork" "subnetwork-public" {
  name          = "public-subnetwork"
  ip_cidr_range = "${var.subnet_cidr_public}"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.name
}

# Create Private subnet
resource "google_compute_subnetwork" "subnetwork-private" {
  name          = "private-subnetwork"
  ip_cidr_range = "${var.subnet_cidr_private}"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.name
}

# Create Router for NAT
resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.subnetwork-public.region
  network = "vpc-network-aut"
}

# Create NAT Gateway and set it up in private subnet
resource "google_compute_router_nat" "nat" {
  name   = "my-router-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.subnetwork-private.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
