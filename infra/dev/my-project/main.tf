terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

variable "project_name" {
  type = string
}

variable "admin_group_id" {
  type = string
}

resource "random_id" "project" {
  byte_length = 8
  keepers = {
    project_name   = var.project_name
    admin_group_id = var.admin_group_id
  }
}

output "project_id" {
  value = random_id.project.hex
}

output "project_name" {
  value = var.project_name
}
