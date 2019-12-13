provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}
