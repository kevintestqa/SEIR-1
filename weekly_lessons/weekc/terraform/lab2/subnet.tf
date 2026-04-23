resource "google_compute_subnetwork" "private" {
  name          = local.subnet_name
  region        = var.region
  network       = google_compute_network.main.id
  ip_cidr_range = "10.0.0.0/18"

  private_ip_google_access = true
}
