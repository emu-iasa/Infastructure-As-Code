provider "google" {
  credentials = "${file("account.json")}"
  project     = "iasa-training"
}

resource "google_compute_instance" "ubuntu" {
  count        = "8" // number of vm instances being set
  name         = "ubuntu-east-${count.index + 1}"
  machine_type = "g1-small" // 0.5 core + 1.65 GB RAM
  zone         = "us-east1-b"


  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = 10
    }
  }
  metadata_startup_script = "sudo apt-get update && sudo apt-get upgrade"
  network_interface {
    network = "default"

    access_config {
      // Will pull a default ip 
    }
  }
}
