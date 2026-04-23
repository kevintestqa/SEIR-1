resource "google_compute_network" "main" {
  name                    = local.network_name
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}
