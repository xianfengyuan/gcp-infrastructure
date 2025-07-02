provider "google" {
  project = var.bootstrap_project_id
  region = "us-west4"
}

module "quota_project" {
  source = "../../modules/quota_project"

  environment = "dev"
  project_name       = "${environment}-quota"
  project_id         = "${environment}-quota-seed"
  billing_account_id = var.billing_account_id
  org_id             = var.org_id  
}
