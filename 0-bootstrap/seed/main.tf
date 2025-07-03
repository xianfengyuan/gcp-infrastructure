terraform {
  backend "gcs" {
    bucket = "cft-tfstate-452e"
    prefix = "terraform/state/seed"  # organize your state, e.g., terraform/state/dev
  }
}

module "bootstrap" {
  source  = "terraform-google-modules/bootstrap/google"
  version = "~> 11.0"

  org_id               = var.org_id
  billing_account      = var.billing_account_id
  group_org_admins     = "gcp-organization-admins@sheermountain.com"
  group_billing_admins = "gcp-billing-admins@sheermountain.com"
  default_region       = "us-west4"
}
