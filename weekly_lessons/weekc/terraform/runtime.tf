resource "null_resource" "get_credentials" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name} --zone ${var.zone} --project ${var.project_id}"
  }

  depends_on = [
    google_container_cluster.primary
  ]
}
