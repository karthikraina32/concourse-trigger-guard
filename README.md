# concourse-trigger-guard
concourse resource type to fail a build when it is triggered by a user that
is not granted access (via GitHub username or team membership).

## Usage

```yaml
resource_types:
- name: manual-trigger-guard
  type: docker-image
  source:
    repository: karthikkumar268/concourse-trigger-guard
    tag: v1.0


resources:
- name: allow-maintainers-guard
  type: manual-trigger-guard
  expose_build_created_by: true
  source:
    access_token: ((access_token))
    users:
    - some-user
    teams:
    - <org_team>/teams/<github_team_name> #team name should be in this format
    v3_endpoint: ((github_endpoint))

jobs:
- name: some-job
  plan:
  - put: allow-maintainers-guard
  - ... # the rest of the job plan
```

With this configuration, `some-job` must be triggered manually, and the build
will fail if it is triggered by a user other than `some-user` or one of the
members of `github team mentioned above`.

Note: the `access_token` must be specified if using the `teams` configuration,
and the access token must be granted the `read:org` permission. The access
token must belong to a user that has visibility to the `teams`.
