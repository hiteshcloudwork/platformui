## Create a firewall rule
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.cloud_ui_poc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}
