resource "google_compute_autoscaler" "autoscaler" {
  name   = "${var.name}-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.mig.id

  autoscaling_policy {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    cpu_utilization {
      target = 0.6
    }
  }
}
