terraform {
  backend "gcs" {
    bucket = "cft-tfstate-452e"
    prefix = "terraform/state/projects"  # organize your state, e.g., terraform/state/dev
  }
}

locals {
  roles = [
    "logging.logWriter",
    "artifactregistry.writer"
  ]
}

resource "google_project" "cloudbuild_project" {
  name            = var.project_name
  project_id      = var.project_id
  billing_account = var.billing_account_id
  org_id          = var.org_id
}

resource "google_project_service" "required_apis" {
  for_each = toset([
    "cloudbuild.googleapis.com",
    "secretmanager.googleapis.com"
  ])
  project = google_project.cloudbuild_project.project_id
  service = each.key
}

resource "google_service_account" "cloudbuild_sa" {
  project = google_project.cloudbuild_project.project_id

  account_id   = "${var.project_name}-sa"
  display_name = "cloudbuild_sa"
}

resource "google_project_iam_member" "cloudbuild_storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:cloudbuild-sa@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "cloud_roles" {
  for_each = zipmap(local.roles, local.roles)

  project = var.project_id
  role = "roles/${each.key}"
  member  = "serviceAccount:cloudbuild-sa@${var.project_id}.iam.gserviceaccount.com"  
}
