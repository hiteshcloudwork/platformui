## Configure the Google Cloud Provider
provider "google" {
  project     = "direct-blend-298007"
  region      = "us-central1"
}

## Create a VPC network
resource "google_compute_network" "cloud_ui_poc_network" {

  ######################
  # Required Arguments #
  ######################
  name                                   = "cloud-ui-net-poc-01"

  ######################
  # Optional Arguments #
  ######################
  auto_create_subnetworks                = false
  # description                          = var.description
  # auto_create_subnetworks              = var.auto_create_subnetworks
  # routing_mode                         = var.routing_mode
  # mtu                                  = var.mtu
  # project                              = var.project
  # delete_default_routes_on_create      = var.delete_default_routes_on_create
}


## Create a subnetwork
resource "google_compute_subnetwork" "cloud_ui_poc_subnetwork" {

  ######################
  # Required Arguments #
  ######################
  name                                    = "cloud-ui-subnet-poc-01"
  ip_cidr_range                           = "10.2.0.0/16"
  network                                 = google_compute_network.cloud_ui_poc_network.id

  ######################
  # Optional Arguments #
  ######################
  region                                         = "us-central1"
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


## Create a service account
resource "google_service_account" "src_acc_poc" {
  account_id = "cloud-ui-sa-poc"

  ######################
  # Optional Arguments #
  ######################
  display_name = "POC Service Account"
  # description  = var.description
  # project      = var.project
}


## Create a persistent disk

data "google_compute_image" "t-compute-image" {
  family  = "rhel-7"
  project = "rhel-cloud"
}

resource "google_compute_disk" "t-compute-disk" {
  name = "cloud-ui-poc-vol"

  #####################################
  # Optional Arguments & Child blocks #
  #####################################

  size  = 60
  type  = "pd-ssd"
  image = data.google_compute_image.t-compute-image.self_link
  zone  = "us-central1-a"
  # description                   = var.description
  # labels                        = var.labels
  # physical_block_size_bytes     = var.physical_block_size_bytes
  # interface                     = var.interface
  # resource_policies             = var.resource_policies
  # snapshot                      = var.snapshot
  # project                       = var.project


  //The source_image_encryption_key block supports:
  /*
  source_image_encryption_key {
    raw_key                    = var.raw_key
    sha256                     = var.sha256
    kms_key_self_link          = var.kms_key_self_link
    kms_key_service_account    = var.kms_key_service_account
  }
*/


  //The disk_encryption_key block supports:
  /*
  disk_encryption_key {
    raw_key                    = var.raw_key
    sha256                     = var.sha256
    kms_key_self_link          = var.kms_key_self_link
    kms_key_service_account    = var.kms_key_service_account
  }
*/


  //The source_snapshot_encryption_key block supports:
  /*
  source_snapshot_encryption_key {
    raw_key                    = var.raw_key
    sha256                     = var.sha256
    kms_key_self_link          = var.kms_key_self_link
    kms_key_service_account    = var.kms_key_service_account
  }
*/

}


## Create a firewall rule
resource "google_compute_firewall" "default" {

  ######################
  # Required Arguments #
  ######################

  name    = "cloud-ui-firewall-poc"
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


## Create a VM instances
resource "google_compute_instance" "cloud_ui_poc_vm" {

  #######################################
  # Required Arguments and Child blocks #
  #######################################
  name         = "cloud-ui-poc"
  zone         = "us-central1-a"
  machine_type = "n1-standard-1"

  boot_disk {
    source = google_compute_disk.t-compute-disk.self_link
  }

  network_interface {
    subnetwork = google_compute_subnetwork.cloud_ui_poc_subnetwork.self_link
  }

  service_account {
    email  = google_service_account.src_acc_poc.email
    scopes = ["cloud-platform"]
  }

  #######################
  # Optional Arguments  #
  #######################

  allow_stopping_for_update = true
  # attached_disk                                      = var.attached_disk
  # can_ip_forward                                     = var.can_ip_forward
  # description                                        = var.description
  # desired_status                                     = var.desired_status
  # deletion_protection                                = var.deletion_protection
  # hostname                                           = var.hostname
  # guest_accelerator                                  = var.guest_accelerator
  # labels                                             = var.labels
  # metadata                                           = var.metadata
  # metadata_startup_script                            = var.metadata_startup_script
  # min_cpu_platform                                   = var.min_cpu_platform
  # project                                            = var.project
  # scheduling                                         = var.scheduling
  # scratch_disk                                       = var.scratch_disk
  # service_account                                    = var.service_account
  tags = ["web"]
  # shielded_instance_config                           = var.shielded_instance_config
  # enable_display                                     = var.enable_display
  # resource_policies                                  = var.resource_policies


  // The boot_disk block supports:
  # auto_delete                                        = var.auto_delete
  # device_name                                        = var.device_name
  # mode                                               = var.mode
  # disk_encryption_key_raw                            = var.disk_encryption_key_raw
  # kms_key_self_link                                  = var.kms_key_self_link
  # initialize_params                                  = var.initialize_params
  # source                                             = var.source


  // The initialize_params block supports:
  # size                                               = var.size
  # type                                               = var.type
  # image                                              = var.image


  // The scratch_disk block supports:
  # interface                                          = var.interface  #Required


  // The attached_disk block supports:
  # source                                             = var.source     #Required
  # device_name                                        = var.device_name
  # mode                                               = var.mode
  # disk_encryption_key_raw                            = var.disk_encryption_key_raw
  # kms_key_self_link                                  = var.kms_key_self_link


  // The network_interface block supports:
  # network                                            = var.network
  # subnetwork                                         = var.subnetwork
  # subnetwork_project                                 = var.subnetwork_project
  # network_ip                                         = var.network_ip
  # access_config                                      = var.access_config
  # alias_ip_range                                     = var.alias_ip_range

  // The access_config block supports:
  # nat_ip                                             = var.nat_ip
  # public_ptr_domain_name                             = var.public_ptr_domain_name
  # network_tier                                       = var.network_tier


  // The alias_ip_range block supports:
  # ip_cidr_range                                      = var.ip_cidr_range
  # subnetwork_range_name                              = var.subnetwork_range_name


  // The service_account block supports:
  # email                                              = var.email
  # scopes                                             = var.scopes  #Required

  // The scheduling block supports:
  # preemptible                                        = var.preemptible
  # on_host_maintenance                                = var.on_host_maintenance
  # automatic_restart                                  = var.automatic_restart
  # node_affinities                                    = var.node_affinities

  // The guest_accelerator block supports:
  # type                                               = var.type #Required
  # count                                              = var.count #Required

  // The node_affinities block supports:
  # key                                                = var.key       #Required
  # operator                                           = var.operator  #Required
  # values                                             = var.values    #Required

  // The shielded_instance_config block supports:
  # enable_secure_boot                                 = var.enable_secure_boot
  # enable_vtpm                                        = var.enable_vtpm
  # enable_integrity_monitoring                        = var.enable_integrity_monitoring
}

