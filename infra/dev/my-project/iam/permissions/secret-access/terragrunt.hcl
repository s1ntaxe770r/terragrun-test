terraform {
  source = "${get_repo_root()}//modules/random-outputs"
}

# Direct dependency on admin-group
dependency "admin_group" {
  config_path = "../../../../../_global/groups/admin-group"
}

# Direct dependency on my-project — which also depends on admin-group.
# Diamond: secret-access -> admin-group (direct)
#          secret-access -> my-project -> admin-group (transitive)
# With cascadeDependencies: true this triggers "edge already exists"
dependency "project" {
  config_path = "../../.."
}

inputs = {
  name = "secret-access"
}
