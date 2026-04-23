variable "environment" {
  description = "Environment name (dev, stage, prod)"
  type        = string
}

variable "node_machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "general_node_count" {
  type    = number
  default = 1
}
