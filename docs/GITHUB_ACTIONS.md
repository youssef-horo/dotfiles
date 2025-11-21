# GitHub Actions

## What is GitHub Actions?

GitHub Actions is a free CI/CD tool integrated directly into GitHub. It runs automatically when you push code.

## Quick Start

1. **Push the workflow file to GitHub:**
   ```bash
   git add .github/workflows/test.yml
   git commit -m "Add GitHub Actions workflow"
   git push
   ```

2. **View workflows:**
   - Go to your repository on GitHub
   - Click the **"Actions"** tab
   - You'll see the "Test Dotfiles" workflow
   - Click on it to see details

3. **Status indicators:**
   - ✅ Green checkmark = All OK
   - ❌ Red X = Error (click for details)
   - 🟡 Yellow circle = Running

## What Gets Tested?

1. **Platform Detection**: Verifies platform detection works
2. **Installation Script**: Tests if `install.sh` runs
3. **Zsh Syntax**: Checks if `.zshrc` has valid syntax
4. **Config Files**: Verifies all platform configs exist
5. **Symlinks**: Checks if correct files exist for symlinks

## Testing Locally (Optional)

You can test workflows locally with `act`:

```bash
# Install act (macOS)
brew install act

# List all workflows
act -l

# Simulate a push
act push

# Simulate a pull request
act pull_request
```

## Workflow Configuration

The workflow file is located at `.github/workflows/test.yml`.

### Current Configuration

- **Triggers**: Push and Pull Requests on `main`/`master`
- **OS**: Tests on `ubuntu-latest` and `macos-latest`
- **Steps**: Platform detection, installation, syntax check, config verification

### Customization

#### Test more OS versions:
```yaml
matrix:
  os: [ubuntu-22.04, ubuntu-20.04, macos-13, macos-12]
```

#### Manual workflow dispatch:
```yaml
on:
  workflow_dispatch:  # Allows manual triggering
```

#### Trigger on tags:
```yaml
on:
  push:
    tags:
      - 'v*'  # On version tags
```

## Costs

- **Public repos**: Free, unlimited
- **Private repos**: 2000 minutes/month free, then $0.008/minute

## Troubleshooting

### Workflow doesn't run?

- Check if file is in `.github/workflows/`
- Verify YAML syntax is correct
- Check if branch is `main` or `master`

### Workflow fails?

- Click on the failed run
- Scroll to the steps
- Click on the failed step to see logs

### Workflow too slow?

- Use `matrix` to test in parallel
- Use caching for dependencies
- Remove unnecessary steps

## Useful Links

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)

