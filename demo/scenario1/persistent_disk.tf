## Create a persistent disk

data "google_compute_image" "t-compute-image" {
    family  = "rhel-cloud"
    project = "rhel-7"
}

resource "google_compute_disk" "t-compute-disk" {
  name                          = "cloud-ui-poc-vol"

#####################################
# Optional Arguments & Child blocks #
#####################################

  size                          = 60
  type                          = "pd-ssd"
  image                         = data.google_compute_image.t-compute-image.self_link
  zone                          = "us-central1-a"
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
