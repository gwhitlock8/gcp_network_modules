terraform {
  required_version = ">= 0.13.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.25.0, < 6"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-network:subnets/v7.5.0"
  }
}