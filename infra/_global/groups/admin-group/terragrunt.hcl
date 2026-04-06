terraform {
  source = "${get_repo_root()}//modules/random-outputs"
}

inputs = {
  name = "admin-group"
}
