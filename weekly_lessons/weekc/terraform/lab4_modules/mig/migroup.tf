resource "google_compute_instance_group_manager" "mig" {
  name               = "${var.name}-mig"
  base_instance_name = var.name
  zone               = var.zone

  version {
    instance_template = google_compute_instance_template.template.id
  }

  target_size = var.min_replicas
}
