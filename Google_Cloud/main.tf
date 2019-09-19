provider "google" {
  credentials = "${file("account.json")}"
  project     = "iasa-training"
  region      = "us-east1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "ubuntu1804"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.vpc_network.self_link}"
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}
