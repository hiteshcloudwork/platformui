## Create a VM instance
resource "google_compute_instance" "cloud_ui_poc_vm" {
  name                        = "test"
  zone                        = "asia-south1-a"
  machine_type                = "n1-standard-1"
  allow_stopping_for_update   = true
  tags                        = ["web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.cloud_ui_poc_network.self_link
  }

  metadata = {
    ssh-keys = 
  }

  service_account {
    email  = google_service_account.src_acc_poc.email
    scopes = ["cloud-platform"]
  }
}
