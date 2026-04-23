#Enable Private Service Networking

resource "google_compute_global_address" "private_ip" {
  name          = "${var.name}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip.name]
}


#Cloud SQL Instance

resource "google_sql_database_instance" "postgres" {
  name             = "${var.name}-postgres"
  region           = var.region
  database_version = var.db_version

  settings {
    tier = var.db_tier

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

#Database

resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres.name
}

#User

resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres.name
  password = var.db_password
}

resource "google_sql_user" "han" {
  name     = var.han_user
  instance = google_sql_database_instance.postgres.name
  password = var.han_password
}

#resource "google_project_service" "sqladmin" {
#  service = "sqladmin.googleapis.com"
#}






