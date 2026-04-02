terraform {
  source = "git::https://github.com/example/modules.git//project?ref=v1.0.0"
}

dependency "admin_group" {
  config_path = "../../_global/groups/admin-group"
}

inputs = {
  project_name   = "my-project"
  admin_group_id = dependency.admin_group.outputs.group_id
}
