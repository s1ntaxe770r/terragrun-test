terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

resource "random_id" "group_id" {
  byte_length = 8
}

resource "random_pet" "group_name" {}

resource "random_integer" "group_priority" {
  min = 1
  max = 100
}

output "group_id"       { value = random_id.group_id.hex }
output "group_name"     { value = random_pet.group_name.id }
output "group_priority" { value = random_integer.group_priority.result }
