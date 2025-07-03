variable "repository_name" {
  type = string
  default = "simplebank"
}

variable "repository_url" {
  type = string
  default = "https://github.com/xianfengyuan/simplebank.git"
}

variable "project_id" {
  type = string
  default = "swan-5bn2"
}

variable "region" {
  type    = string
  default = "us-west4"
}

variable "github_pat_secret_value" {
  type = string
}

variable "github_app_id_secret_value" {
  type = string
}
