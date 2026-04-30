terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

#300 random_string resources at 500 chars each
# each resource produces ~600+ chars of plan output -> ~180k chars total
resource "random_string" "large" {
  count   = 330
  length  = 500
  special = true
  upper   = true
  lower   = true
  numeric = true
}

# 300 random_password resources at 500 chars each - plan shows "(sensitive value)"
# but the resource block itself adds volume
resource "random_password" "large" {
  count            = 300
  length           = 500
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}|;:,.<>?"
}

# 300 random_id resources - shows hex/b64 output in plan
resource "random_id" "large" {
  count       = 300
  byte_length = 64
}

# 300 random_integer resources
resource "random_integer" "large" {
  count = 300
  min   = 1
  max   = 999999999
}

# outputs to make the plan even longer
output "strings" {
  value = random_string.large[*].result
}

output "ids" {
  value = random_id.large[*].hex
}

output "integers" {
  value = random_integer.large[*].result
}
