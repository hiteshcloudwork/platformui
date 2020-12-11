## Create a firewall rule
resource "google_compute_firewall" "default" {

######################
# Required Arguments #
######################
  
  name    = "test-firewall"
  network = google_compute_network.cloud_ui_poc_network.name

######################
# Optional Arguments #
######################
  
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]

# allow                         = var.allow
# deny                          = var.deny
# description                   = var.description
# destination_ranges            = var.destination_ranges
# direction                     = var.direction
# disabled                      = var.disabled
# log_config                    = var.log_config
# priority                      = var.priority
# source_ranges                 = var.source_ranges
# source_service_accounts       = var.source_service_accounts
# source_tags                   = var.source_tags
# target_service_accounts       = var.target_service_accounts
# target_tags                   = var.target_tags
# project                       = var.project
# enable_logging                = var.enable_logging

// The allow block supports:
# protocol                      = var.protocol #Required
# ports                         = var.ports


// The deny block supports:
# protocol                      = var.protocol #Required
# ports                         = [var.ports]


// The log_config block supports:
# metadata        = var.metadata #Required
}
