terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

variable "project_id" {
  type = string
}

variable "group_id" {
  type = string
}

variable "role" {
  type = string
}

resource "random_id" "binding" {
  byte_length = 8
  keepers = {
    project_id = var.project_id
    group_id   = var.group_id
    role       = var.role
  }
}

output "binding_id" {
  value = random_id.binding.hex
}

output "role" {
  value = var.role
}
