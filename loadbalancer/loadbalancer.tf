// Forwarding rule for External Network Load Balancing using Backend Services
resource "google_compute_forwarding_rule" "t-google-compute-forwarding-rule" {
  provider              = google-beta
  name                  = "cloud-platform-ui-website-forwarding-rule"
  region                = "us-central1"
  port_range            = 80
  backend_service       = google_compute_region_backend_service.t-google-compute-region-backend-service.id
}
resource "google_compute_region_backend_service" "t-google-compute-region-backend-service" {
  provider              = google-beta
  name                  = "cloud-platform-ui-website-backend"
  region                = "us-central1"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_region_health_check.t-google-compute-region-health-check.id]
}
resource "google_compute_region_health_check" "t-google-compute-region-health-check" {
  provider           = google-beta
  name               = "cloud-platform-ui-check-website-backend"
  check_interval_sec = 1
  timeout_sec        = 1
  region             = "us-central1"

  tcp_health_check {
    port = "80"
  }
}
