terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

resource "null_resource" "unit_b" {
  triggers = {
    name = "unit-b"
  }
}
