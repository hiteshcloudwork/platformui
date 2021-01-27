# Create a Cloud DNS

resource "google_dns_managed_zone" "example" {

######################
# Required Arguments #
######################

  name     = "example"
  dns_name = "example.com."
  
#######################
# Optional Arguments  #
#######################

// The following arguments are supported:
# description                                           = var.description
# labels                                                = var.labels
# visibility                                            = var.visibility
# private_visibility_config                             = var.private_visibility_config
# forwarding_config                                     = var.forwarding_config
# peering_config                                        = var.peering_config
# reverse_lookup                                        = var.reverse_lookup
# service_directory_config                              = var.service_directory_config
# project                                               = var.project
# force_destroy                                         = var.force_destroy


// The dnssec_config block supports:
/*
  dnssec_config {
    kind                                               = var.kind
    non_existence                                      = var.non_existence
    state                                              = var.state
    default_key_specs {
	  algorithm                                        = var.algorithm
      key_length                                       = var.key_length
      key_type                                         = var.key_type
      kind                                             = var.kind
	}
}
*/

// The private_visibility_config block supports:
# networks                                              = var.networks

// The networks block supports:
# network_url                                           = var.network_url

// The forwarding_config block supports:
# target_name_servers                                   = var.target_name_servers

// The target_name_servers block supports:
# ipv4_address                                          = var.ipv4_address
# forwarding_path                                       = var.forwarding_path

// The peering_config block supports:
# target_network                                        = var.target_network

// The target_network block supports:
# network_url                                           = var.network_url

// The service_directory_config block supports:
# namespace                                             = var.namespace

// The namespace block supports:
# namespace_url                                         = var.namespace_url
  
}

resource "google_dns_record_set" "example" {
  managed_zone = google_dns_managed_zone.example.name
  name    = "www.${google_dns_managed_zone.example.dns_name}"
  type    = "A"
  rrdatas = var.rrdatas
  ttl     = 300
# project = var.project
}
