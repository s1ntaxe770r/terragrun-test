terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

variable "name" {
  type = string
}

resource "random_id" "id" {
  byte_length = 8
  keepers     = { name = var.name }
}

resource "random_pet" "label" {
  keepers = { name = var.name }
}

resource "random_integer" "priority" {
  min     = 1
  max     = 100
  keepers = { name = var.name }
}

output "id" {
  value = random_id.id.hex
}

output "label" {
  value = random_pet.label.id
}

output "priority" {
  value = random_integer.priority.result
}

# aliases so dependants can reference group_id / project_id by name
output "group_id"   { value = random_id.id.hex }
output "project_id" { value = random_id.id.hex }
