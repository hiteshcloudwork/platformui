## Infrastructure variables
 variable "boot_disk"                    { default = "" }
 variable "scratch_disk"                 { default = "" }
 variable "attached_disk"                { default = "" }
 variable "access_config"                { default = "" }
 variable "alias_ip_range"               { default = "" }
 variable "scheduling"                   { default = "" }
 variable "guest_accelerator"            { default = "" }
 variable "node_affinities"              { default = "" }
 variable "shielded_instance_config"     { default = "" }


## Create a VM instances
resource "google_compute_instance" "cloud_ui_poc_vm" {
  
#######################################
# Required Arguments and Child blocks #
#######################################
  name                        = "test"
  zone                        = "us-central1-a"
  machine_type                = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "rhel-cloud/rhel-7"
    }
  }

  network_interface {
    network = google_compute_network.cloud_ui_poc_network.self_link
  }

  dynamic "service_account" {
    for_each = var.service_account != "" ? [1] : []

    content {
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
/*
  dynamic "boot_disk" {
    for_each = var.boot_disk != "" ? [1] : []

    content {
      auto_delete                                    = var.auto_delete
      device_name                                    = var.device_name
      mode                                           = var.mode
      disk_encryption_key_raw                        = var.disk_encryption_key_raw
      kms_key_self_link                              = var.kms_key_self_link
      initialize_params                              = var.initialize_params
      source                                         = var.source
      }
    }
*/
      
// The initialize_params block supports:
/*
  initialize_params {    
      size                                           = var.size
      type                                           = var.type
      image                                          = var.image
    }
*/

// The scratch_disk block supports:
/*
      dynamic "scratch_disk" {
        for_each = var.scratch_disk != "" ? [1] : []
      
        content {
          interface = var.interface  #Required
        }
      }
*/

// The attached_disk block supports:
/*
      dynamic "attached_disk" {
        for_each = var.attached_disk != "" ? [1] : []
        
        content {
          source                                     = var.source     #Required
          device_name                                = var.device_name
          mode                                       = var.mode
          disk_encryption_key_raw                    = var.disk_encryption_key_raw
          kms_key_self_link                          = var.kms_key_self_link
          }
        }
*/

// The network_interface block supports:
/*
    network_interface {      
          network                                            = var.network
          subnetwork                                         = var.subnetwork
          subnetwork_project                                 = var.subnetwork_project
          network_ip                                         = var.network_ip
          access_config                                      = var.access_config
          alias_ip_range                                     = var.alias_ip_range
      }
*/

// The access_config block supports:
/*
    dynamic "access_config" {
      for_each = var.access_config != "" ? [1] : []
      
      content {      
        nat_ip                                             = var.nat_ip
        public_ptr_domain_name                             = var.public_ptr_domain_name
        network_tier                                       = var.network_tier
        }
      }
*/

// The alias_ip_range block supports:
/*
    dynamic "alias_ip_range" {
      for_each = var.alias_ip_range != "" ? [1] : []
      
      content {    
        ip_cidr_range                                      = var.ip_cidr_range
        subnetwork_range_name                              = var.subnetwork_range_name
        }
      }
*/


// The scheduling block supports:
/*
    dynamic "scheduling" {
      for_each = var.scheduling != "" ? [1] : []
      
      content { 
        preemptible                                        = var.preemptible
        on_host_maintenance                                = var.on_host_maintenance
        automatic_restart                                  = var.automatic_restart
        node_affinities                                    = var.node_affinities
        }
      }
*/

// The guest_accelerator block supports:
/*
    dynamic "guest_accelerator" {
      for_each = var.guest_accelerator != "" ? [1] : []
      
      content {
        type                                               = var.type #Required
        count                                              = var.count #Required
        }
      }
*/

// The node_affinities block supports:
/*
    dynamic "node_affinities" {
      for_each = var.node_affinities != "" ? [1] : []
      
      content {
        key                                                = var.key       #Required
        operator                                           = var.operator  #Required
        values                                             = var.values    #Required
        }
      }
*/

// The shielded_instance_config block supports:
/*
    dynamic "shielded_instance_config" {
      for_each = var.shielded_instance_config != "" ? [1] : []
      
      content {
        enable_secure_boot                                 = var.enable_secure_boot
        enable_vtpm                                        = var.enable_vtpm
        enable_integrity_monitoring                        = var.enable_integrity_monitoring
        }
      }
*/
}
