# Sentinel GitHub Action

This GitHub Action workflow, named **Sentinel**, is designed to perform policy evaluations against Terraform plans within pull requests. It ensures that infrastructure-as-code adheres to defined policies using HashiCorp's Sentinel policy as code framework.

## Workflow Configuration

The workflow is triggered on every pull request.

```yaml
name: Sentinel
on: [pull_request]
```

## Job Configuration
### Job: sentinel

This job, named **Sentinel**, runs on the latest version of Ubuntu and is responsible for policy evaluation.

```yaml
jobs:
  sentinel:
    name: Sentinel
    runs-on: ubuntu-latest
```

### Environment Variables
- **VERSION:** Specifies the version of Sentinel to be used (default: '0.24.1').

```yaml
env:
    STL_VERSION: '0.26.3'
```

## Job Steps

1. Checkout Code

    This step checks out the repository's code.

```yaml
- uses: actions/checkout@v3
```

2. Setup Sentinel

    Downloads and sets up the Sentinel binary for policy evaluation.

```yaml
 - name: Setup Sentinel
        uses: hashicorp/setup-sentinel@main
        id: setup
        with:
          version: ${{ env.STL_VERSION }}
```

3. Policy Evaluation

    Executes the Sentinel command for policy evaluation using a specified configuration file.

    > **NOTE**: This step runs the policy and outputs whether the policy `passed` or `failed`.
    >
    > The exit code also reflects the status of the policy:
    > - 0 = pass
    > - 1 = fail
    > - 2 = undefined (fail, but result was undefined)
    > - 3 = error.

```yaml
- name: Policy Evaluation
  run: sentinel apply -config=$WORKING_DIR/sentinel.hcl
```
