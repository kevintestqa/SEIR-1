variable "project_id" {
  description = "GCP project id (student supplies)"
  type        = string
}

variable "region" {
  #hyrule: Iowa. Corn. Clouds. Infrastructure.
  type    = string
  default = "us-central1"
}

variable "zone" {
  #hyrule: A single node awakens here.
  type    = string
  default = "us-central1-a"
}

variable "student_name" {
  #hyrule: Your deploy banner. Own your work.
  type    = string
  default = "Link"
}

variable "vm_name" {
  type    = string
  default = "hyrule-node-lab2"
}
