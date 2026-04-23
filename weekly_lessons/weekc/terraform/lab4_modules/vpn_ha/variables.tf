variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type = string
}

variable "router_name" {
  type = string
}

variable "local_bgp_asn" {
  type = number
}

variable "peer_bgp_asn" {
  type = number
}

variable "peer_gateway_redundancy_type" {
  type    = string
  default = "TWO_IPS_REDUNDANCY"
}

variable "peer_interface_0_ip" {
  type = string
}

variable "peer_interface_1_ip" {
  type = string
}

variable "shared_secret_0" {
  type      = string
  sensitive = true
}

variable "shared_secret_1" {
  type      = string
  sensitive = true
}

variable "bgp_ip_range_0" {
  type = string
  # example: 169.254.10.1/30
}

variable "bgp_peer_ip_0" {
  type = string
  # example: 169.254.10.2
}

variable "bgp_ip_range_1" {
  type = string
  # example: 169.254.20.1/30
}

variable "bgp_peer_ip_1" {
  type = string
  # example: 169.254.20.2
}
