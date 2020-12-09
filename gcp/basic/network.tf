## Create a VPC network
resource "google_compute_network" "cloud_ui_poc_network" {
  name                    = "cloud-ui-poc-01"
  auto_create_subnetworks = false
}

## Create a subnetwork
resource "google_compute_subnetwork" "cloud_ui_poc_subnetwork" {
  name          = "poc-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-south1"
  network       = google_compute_network.cloud_ui_poc_network.id
}
