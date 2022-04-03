terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("../sensitive_data/neverland.json")

  project = "neverland-346117"
  region  = "europe-west6"
  zone    = "europe-west6-a"
}

