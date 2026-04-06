terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

resource "random_id" "project_id" {
  byte_length = 8
}

resource "random_pet" "project_name" {}

resource "random_integer" "project_number" {
  min = 1000
  max = 9999
}

output "project_id"     { value = random_id.project_id.hex }
output "project_name"   { value = random_pet.project_name.id }
output "project_number" { value = random_integer.project_number.result }
