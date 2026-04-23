output "mig_name" {
  value = google_compute_instance_group_manager.mig.name
}

output "instance_group" {
  value = google_compute_instance_group_manager.mig.instance_group
}
