resource "google_project" "quota_project" {
  name            = var.project_name
  project_id      = var.project_id
  billing_account = var.billing_account_id
  org_id          = var.org_id

  labels = {
    environment = var.environment
    purpose     = "quota"
  }
}

resource "google_project_service" "required_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com"
  ])
  project = google_project.quota_project.project_id
  service = each.key
}
