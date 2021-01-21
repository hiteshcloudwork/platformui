## Create a VM instances
resource "google_compute_instance" "cloud_ui_poc_vm" {
  
#######################################
# Required Arguments and Child blocks #
#######################################
  name                        = "Cloud-UI-POC"
  zone                        = "us-central1-a"
  machine_type                = "n1-standard-1"

  boot_disk {
    source = google_compute_disk.t-compute-disk.self_link
  }

  network_interface {
    network = google_compute_network.cloud_ui_poc_network.self_link
  }

  service_account {
    email  = google_service_account.src_acc_poc.email
    scopes = ["cloud-platform"]
  }
  
#######################
# Optional Arguments  #
#######################

allow_stopping_for_update                           = true
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
tags                                                 = ["web"]
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
