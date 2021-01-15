## Create a subnetwork
resource "google_compute_subnetwork" "cloud_ui_poc_subnetwork" {
  
######################
# Required Arguments #
######################
  name                                         = "cloud-ui-subnet-poc-01"
  ip_cidr_range                                = "10.2.0.0/16"
  network                                      = google_compute_network.cloud_ui_poc_network.id
  
######################
# Optional Arguments #
######################
  region                                       = "us-central1"
# description                                  = var.description
# purpose                                      = var.purpose
# role                                         = var.role
# secondary_ip_range                           = var.secondary_ip_range
# private_ip_google_access                     = var.private_ip_google_access
# private_ipv6_google_access                   = var.private_ipv6_google_access
# region                                       = var.region
# log_config                                   = var.log_config
# project                                      = var.project


// The secondary_ip_range block supports:
# range_name                                   = var.range_name     #Required
# ip_cidr_range                                = var.ip_cidr_range  #Required

// The log_config block supports:
# aggregation_interval                         = var.aggregation_interval
# flow_sampling                                = var.flow_sampling
# metadata                                     = var.metadata
# metadata_fields                              = var.metadata_fields
# filter_expr                                  = var.filter_expr
}
