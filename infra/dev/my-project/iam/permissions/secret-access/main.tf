terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

resource "random_id" "binding_id" {
  byte_length = 8
}

resource "random_pet" "binding_label" {}

resource "random_integer" "binding_priority" {
  min = 1
  max = 50
}

output "binding_id"       { value = random_id.binding_id.hex }
output "binding_label"    { value = random_pet.binding_label.id }
output "binding_priority" { value = random_integer.binding_priority.result }
