resource "google_service_account" "src_acc_poc" {
  account_id   = "cloud-ui-sa-poc"
  
######################
# Optional Arguments #
######################
  display_name = "POC Service Account"
# description  = var.description
# project      = var.project
}
