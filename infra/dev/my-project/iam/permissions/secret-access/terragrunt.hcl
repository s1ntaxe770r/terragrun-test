terraform {
  source = "git::https://github.com/example/modules.git//iam-binding?ref=v1.0.0"
}

# Direct dependency on admin-group
dependency "admin_group" {
  config_path = "../../../../../_global/groups/admin-group"
}

# Direct dependency on my-project — which also depends on admin-group
# This creates a diamond: secret-access -> admin-group (direct)
#                         secret-access -> my-project -> admin-group (transitive)
# With cascadeDependencies: true this causes "edge already exists"
dependency "project" {
  config_path = "../../.."
}

inputs = {
  project_id   = dependency.project.outputs.project_id
  group_id     = dependency.admin_group.outputs.group_id
  role         = "roles/secretmanager.secretAccessor"
  # trigger: reproduce diamond dependency bug
  app = prod
}
