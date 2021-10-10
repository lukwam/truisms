terraform {
  backend "gcs" {
    bucket = "lukwam-truisms-tf"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.84.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "3.84.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "billing_account_display_name" {}
variable "branch" {}
variable "folder_id" {}
variable "github_login" {}
variable "project_id" {}
variable "project_name" {}
variable "region" {
  default = "us-east4"
}
variable "repo" {}