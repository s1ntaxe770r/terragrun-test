terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

variable "group_name" {
  type = string
}

resource "random_id" "group" {
  byte_length = 8
  keepers = {
    group_name = var.group_name
  }
}

output "group_id" {
  value = random_id.group.hex
}

output "group_name" {
  value = var.group_name
}
