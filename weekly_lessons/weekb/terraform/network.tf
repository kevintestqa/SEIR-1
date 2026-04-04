resource "google_compute_network" "zoras_domain" {
  name = "vpc-network"
  project = var.project_id
  auto_create_subnetworks = false
  mtu = 1460
}

resource "google_compute_subnetwork" "death_mountain" {
  name          = "subnet"
  ip_cidr_range = "10.10.30.0/24"
  region        = "us-central1"
  network       = google_compute_network.zoras_domain.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "10.10.20.0/24"
  }
}

resource "google_compute_firewall" "hyrule_allow_http" {
  name    = "hyrule-allow-http"
  network = google_compute_network.zoras_domain.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}