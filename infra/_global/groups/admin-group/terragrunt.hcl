terraform {
  source = "git::https://github.com/example/modules.git//iam-group?ref=v1.0.0"
}

inputs = {
  group_name = "admin-group"
}
