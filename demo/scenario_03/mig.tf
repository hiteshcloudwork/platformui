# Create an instance template
resource "google_compute_instance_template" "template" {
  name_prefix  = "my-template-"
  machine_type = "n1-standard-1"
  tags         = ["sample"]

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.cloud_ui_poc_subnetwork.self_link
  }

  disk {
    source      = google_compute_disk.t-compute-disk.name
    auto_delete = true
    boot        = true
  }

  service_account {
    email  = google_service_account.src_acc_poc.email
    scopes = ["storage-rw"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "google_compute_region_instance_group_manager" "cloud_ui_poc_mig" {
  name                      = substr("my-mig-${md5(google_compute_instance_template.template.name)}", 0, 63)
  region                    = "us-central1"
  base_instance_name        = "mig-instance"
  target_size               = 1
  wait_for_instances        = true
  distribution_policy_zones = ["us-central1-a"]

  version {
    name              = "appserver"
    instance_template = google_compute_instance_template.template.self_link
  }

  lifecycle {
    create_before_destroy = true
  }
}
