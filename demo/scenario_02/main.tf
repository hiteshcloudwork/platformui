¬í të
 ## Create a VM instance
 resource "google_compute_instance" "cloud_ui_poc_vm" { 
 name = "cloud-ui-poc"
 zone = "us-central1-a"
 machine_type = "n1-standard-1"
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
 # Create a Cloud DNS
 resource "google_dns_managed_zone" "example" { 
 name = "cloudui"
 dns_name = "cloudui.com." 
 }
 resource "google_dns_record_set" "example" {
 managed_zone =google_dns_managed_zone.example.name
 name = "www.${google_dns_managed_zone.example.dns_name}"
 type = "A"
 rrdatas = ["8.8.8.8"]
 ttl = 300
}
 ## Create a VPC network 
 resource "google_compute_network" "cloud_ui_poc_network"  {
 name =  "cloud-ui-net-poc-01"
}
 ## Create a subnetwork
 resource "google_compute_subnetwork" "cloud_ui_poc_subnetwork" {
 name = "cloud-ui-subnet-poc-01"
 ip_cidr_range = "10.2.0.0/16"
 network = google_compute_network.cloud_ui_poc_network.id
 region = "us-central1"
 }## Create a Service Network
 resource "google_service_account" "src_acc_poc" {
 account_id="cloud-ui-sa-poc"
 display_name="POC Service Account"
 } 
 ## Create a Firewall
 resource "google_compute_firewall" "default" {
 name = "cloud-ui-firewall-poc"
 network = google_compute_network.cloud_ui_poc_network.name
 source_tags = ["web"]
 allow { 
 protocol =  "icmp" 
 }
 allow { 
 protocol =  "tcp" 
  ports = ["80", "8080", "1000-2000"]
 }
 }
 ## Create a persistent disk
 data "google_compute_image" "t-compute-image" {
 family = "rhel-7"
 project = "rhel-cloud" 
 }
 resource "google_compute_disk" "t-compute-disk" { 
 name= "cloud-ui-poc-vol"
 size = 60
 type = "pd-ssd"
 image = data.google_compute_image.t-compute-image.self_link
 zone = "us-central1-a"
 }
 ## Configure the Google Cloud Provider
 provider "google" {
 project = "direct-blend-298007"
 region = "us-central1"
}
 # Create an instance template
 resource "google_compute_instance_template" "template"  {
 name_prefix = "my-template-"
 machine_type = "n1-standard-1"
 tags = ["sample"]
 scheduling {
 automatic_restart =  true
 on_host_maintenance="MIGRATE" 
 }
 network_interface {  
 subnetwork=google_compute_subnetwork.cloud_ui_poc_subnetwork.self_link
 }
 disk { 
 source=google_compute_disk.t-compute-disk.name
 auto_delete = true
 boot = true
 }
 service_account { 
 email = google_service_account.src_acc_poc.email
 scopes=["storage-rw"]
 }
 lifecycle { 
 create_before_destroy = true
 } 
  }
 resource "google_compute_region_instance_group_manager" "cloud_ui_poc_mig" { 
 name = substr("my-mig-${md5(google_compute_instance_template.template.name)}", 0, 63)
 region = "us-central1"
 base_instance_name = "mig-instance"
 target_size = 1
 wait_for_instances = true
 distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
 version { #name = "appserver"
 instance_template = google_compute_instance_template.template.self_link
 }
 lifecycle { 
 create_before_destroy = true
 }
 }
 # Create a SQL Database and DB instance
 resource "google_sql_database_instance" "db_instance" {
 name = "postgresmaster1"
 database_version = "POSTGRES_11" 
 
 settings { 
 tier = "db-f1-micro" 
 }
  deletion_protection = "true" 
 }
 resource "google_sql_database" "database" { 
 name = "user"
 instance=google_sql_database_instance.db_instance.name
 }
 resource "random_password" "password" { 
 length = 16
 special = true
 override_special = "_%@" 
 }
 resource "google_sql_user" "users" { 
 name = "cloud_ui_user"
 instance = google_sql_database_instance.db_instance.name
 host = "*"
 password = random_password.password.result
 }
