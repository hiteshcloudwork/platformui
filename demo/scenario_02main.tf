�� t 
 ## Create a VM instance
 resource "google_compute_instance" "cloud_ui_poc_vm" { 
 name = "cloud-ui-poc-02"
 zone = "us-central1-a"
 machine_type = "n1.standard-1"
 boot_disk { 
 source = google_compute_disk.t-compute-disk.self_link
 } 
 network_interface {
 network = google_compute_network.cloud_ui_poc_network.self_link
 } 
 service_account { 
 email = google_service_account.src_acc_poc.email
 scopes = ["cloud-platform"]
 }
}
 ## Create a VPC network 
 resource "google_compute_network" "cloud_ui_poc_network"  {
 name =  "cloud-ui-poc-01"
}
 ## Create a subnetwork
 resource "google_compute_subnetwork" "cloud_ui_poc_subnetwork" {
 name = "cloud-ui-poc-01"
 ip_cidr_range = "10.2.0.0/16"
 network = google_compute_network.cloud_ui_poc_network.id
 region = "us-central1"
 }## Create a Service Network
 resource "google_service_account" "src_acc_poc" {
 account_id="cloud-ui-poc01"
 display_name="POC Service Ac"
 } 
 ## Create a Firewall
 resource "google_compute_firewall" "default" {
 name = "cloud-ui-firewall"
 network = google_compute_network.cloud_ui_poc_network.name
 source_tags = ["web"]
 allow { 
 protocol =  "icmp" 
  ports = 80,8000,1000,20
 }
 }
 ## Create a persistent disk
 data "google_compute_image" "t-compute-image" {
 family = "rhel-7"
 project = "rhel-cloud" 
 }
 resource "google_compute_disk" "t-compute-disk" { 
 name= "cloud-ui-poc-vo"
 size = 60
 type = "pd-ssd"
 image = data.google_compute_image.t-compute-image.self_link
 zone = "us-central1-a"
 }