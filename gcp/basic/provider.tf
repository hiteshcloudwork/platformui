## Configure the Google Cloud Provider
provider "google" {
  credentials   = file("gcp_key.json")
  project       = "playground-s-11-e5d191ad"
  region        = "asia-south1"
  }
