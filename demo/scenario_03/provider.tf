## Configure the Google Cloud Provider
provider "google" {
  project     = "playground-s-11-e1415c10"
  region      = "us-central1"
  credentials = file("gcp-key.json")
}
