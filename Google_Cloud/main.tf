provider "google" {
  project     = "iasa-training" // GCP Project Name
  region      = "us-central" // GCP project region
  zone        = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  count        = "30" // number of vm instances being set
  name         = "ubuntu${count.index+1}"
  machine_type = "g1-small" // 0.5 vCPUs 1.7 GB RAM

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts" // ubuntu 18.04 LTS
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.vpc_network.self_link}" // does magic
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"  
  auto_create_subnetworks = "true" 
}