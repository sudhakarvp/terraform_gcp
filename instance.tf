# Assign public IP
resource "google_compute_address" "static" {
  name = "ipv4-address"
}

# Create App server instance
resource "google_compute_instance" "appserver" {
  name = "primary-application-server"
  machine_type = "n1-standard-1"
  zone = "${var.zone}"
  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "vpc-network-aut"
    subnetwork = google_compute_subnetwork.subnetwork-public.name
    access_config {
    }
  }
}

# Create DB instance in private subnet and with NO Public IP
resource "google_compute_instance" "dbserver" {
  name = "db-server"
  machine_type = "n1-standard-1"
  zone = "${var.zone}"
  tags = ["db"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "vpc-network-aut"
    subnetwork = google_compute_subnetwork.subnetwork-private.name
  }
}
