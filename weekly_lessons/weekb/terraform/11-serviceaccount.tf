resource "google_service_account" "service_a" {
  account_id = "thailand"
}

resource "google_project_iam_member" "service_a_storage_admin" {
  project = "thailand-433607"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.service_a.email}"
}

resource "google_service_account_iam_member" "service_a_workload_identity" {
  service_account_id = google_service_account.service_a.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:thailand-433607.svc.id.goog[staging/service-a]"
}
