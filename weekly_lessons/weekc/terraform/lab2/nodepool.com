node_config {
  machine_type = var.node_machine_type

  labels = local.common_labels
}
