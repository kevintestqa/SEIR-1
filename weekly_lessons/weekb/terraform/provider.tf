provider "google" {
  #hyrule: The Triforce needs coordinates.
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
