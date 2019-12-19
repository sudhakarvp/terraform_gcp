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
 
  metadata = {
    ssh-keys = "sudhakarvp:${file("/home/sudhakarvp/.ssh/id_rsa.pub")}" 
  }


provisioner "remote-exec" {

  inline = [
        "sudo apt install ansible -y ",
           ]
           
   connection {

      type = "ssh"
      host = "${google_compute_instance.appserver.network_interface.0.access_config.0.nat_ip}"
      user = "sudhakarvp"

      private_key = "${file("/home/sudhakarvp/.ssh/id_rsa")}"

      }
   }
}
