output "ha_vpn_gateway_name" {
  value = google_compute_ha_vpn_gateway.gcp.name
}

output "tunnel_0_name" {
  value = google_compute_vpn_tunnel.tunnel0.name
}

output "tunnel_1_name" {
  value = google_compute_vpn_tunnel.tunnel1.name
}

output "router_name" {
  value = google_compute_router.router.name
}
