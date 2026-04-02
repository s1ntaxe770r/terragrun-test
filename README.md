# terragrun-test

Reproduction repo for https://github.com/diggerhq/digger/issues/2628

## Issue

Digger fails to parse Terragrunt configurations with cascaded dependencies when a diamond dependency exists (module A and module B both depend on module C, and module A also depends on module B).

## Structure

```
infra/
├── _global/groups/admin-group/       # shared resource
├── dev/my-project/                   # depends on admin-group
└── dev/my-project/iam/permissions/secret-access/  # depends on BOTH my-project AND admin-group
```

## Reproduce

Open a PR touching `infra/dev/my-project/iam/permissions/secret-access/terragrunt.hcl`.

Expected error from orchestrator:

```
failed to create project dependency graph: edge already exists
```
