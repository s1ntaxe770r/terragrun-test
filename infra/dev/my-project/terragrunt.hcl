terraform {
  source = "${get_repo_root()}//modules/random-outputs"
}

dependency "admin_group" {
  config_path = "../../_global/groups/admin-group"
}

inputs = {
  name = "my-project"
}
