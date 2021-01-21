## Create a VPC network
resource "google_compute_network" "cloud_ui_poc_network" {

######################
# Required Arguments #
######################
  name                                 = "cloud-ui-net-poc-01"

######################
# Optional Arguments #
######################
  auto_create_subnetworks              = false
# description                          = var.description
# auto_create_subnetworks              = var.auto_create_subnetworks
# routing_mode                         = var.routing_mode
# mtu                                  = var.mtu
# project                              = var.project
# delete_default_routes_on_create      = var.delete_default_routes_on_create
}
