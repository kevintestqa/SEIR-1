variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type = string
}

variable "db_version" {
  type    = string
  default = "POSTGRES_14"
}

variable "db_tier" {
  type    = string
  default = "db-f1-micro"
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "han_user" {
  type = string
}

variable "han_password" {
  type      = string
  sensitive = true
}
