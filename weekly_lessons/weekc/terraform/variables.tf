variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "primary"
}

variable "network_name" {
  description = "VPC Network Name"
  type        = string
  default     = "main"
}

variable "subnetwork_name" {
  description = "Subnetwork Name"
  type        = string
  default     = "private"
}
