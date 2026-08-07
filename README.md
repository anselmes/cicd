# CICD - Comprehensive CI/CD Toolkit

A reusable CI/CD toolkit providing GitHub Actions workflows, development containers, and automation scripts for modern software development projects.

---

[![OpenSSF Scorecard][ossf-score-badge]][ossf-score-link]
[![Contiuos Integration][ci-badge]][ci-link]
[![Review][review-badge]][review-link]

[ossf-score-badge]: https://api.securityscorecards.dev/projects/github.com/anselmes/cicd/badge
[ossf-score-link]: https://securityscorecards.dev/viewer/?uri=github.com/anselmes/cicd
[ci-badge]: https://github.com/anselmes/cicd/actions/workflows/ci.yml/badge.svg
[ci-link]: https://github.com/anselmes/cicd/actions/workflows/ci.yml
[review-badge]: https://github.com/anselmes/cicd/actions/workflows/required/anselmes/cicd/.github/workflows/review.yml/badge.svg
[review-link]: https://github.com/anselmes/cicd/actions/workflows/required/anselmes/cicd/.github/workflows/review.yml

---

## Features

### 🚀 Workflows

`container.yml`, `chart.yml`, `build.yml`, `package.yml`, and `plugin.yml` are
thin wrappers — hardened runner, checkout, and artifact upload — around
composite actions in the sibling [`clact`](https://github.com/anselmes/clact)
repository.

| Workflow        | Purpose                                                          | Trigger                                                                   |
| --------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------- |
| `ci.yml`        | Lints the repo and orchestrates `bot`, `trivy`, and `scorecard`  | `push`                                                                    |
| `review.yml`    | Labels, dependency-reviews, and auto-assigns pull requests       | `pull_request`                                                            |
| `bot.yml`       | Dependabot auto-approve/merge; publishes a release on tag push   | `workflow_call`                                                           |
| `trivy.yml`     | Filesystem vulnerability scan and SBOM submission                | `workflow_call`                                                           |
| `scorecard.yml` | OpenSSF Scorecard analysis                                       | `workflow_call`                                                           |
| `cleanup.yml`   | Stale issue/PR management and Actions cache cleanup              | `pull_request` (closed), `schedule`, `workflow_call`, `workflow_dispatch` |
| `container.yml` | Multi-platform container image build/publish                     | `workflow_call`                                                           |
| `chart.yml`     | Helm chart build/publish                                         | `workflow_call`                                                           |
| `build.yml`     | Go/Rust/Swift binary build, with macOS codesign/notarize support | `workflow_call`                                                           |
| `package.yml`   | Python wheel build                                               | `workflow_call`                                                           |
| `plugin.yml`    | Claude plugin bundle build                                       | `workflow_call`                                                           |

### 🔧 Development Environment

- **DevContainer**: Pre-configured development environment with Ubuntu 24.04
- **Shell Configuration**: Oh My Zsh setup with custom aliases and environment variables
- **Tool Integration**: Built-in support for various development tools and runtimes

### 📋 Code Quality & Security

- **Linting**: Comprehensive linting with Trunk, Super Linter, and language-specific tools
- **Security Scanning**: Multi-layer security with Trivy, Semgrep, Gitleaks, and TruffleHog
- **Dependency Management**: Automated dependency updates and vulnerability monitoring
- **Code Standards**: EditorConfig, Prettier, and pre-commit hooks

## Quick Start

### Using as a Template

1. Clone this repository
2. Customize the workflows in [`.github/workflows/`](.github/workflows/) for your needs
3. Update configuration files as needed

### Using Reusable Workflows

Reference the workflows in your repository:

```yaml
name: CI
on: [push, pull_request]

jobs:
  review:
    uses: anselmes/cicd/.github/workflows/review.yml@main

  security:
    uses: anselmes/cicd/.github/workflows/trivy.yml@main
    permissions:
      contents: read
      security-events: write
```

### Using Composite Actions

Container and Helm chart builds are provided as composite actions in the sibling
[`clact`](https://github.com/anselmes/clact) repository. Call them directly:

```yaml
- name: Build Container
  uses: anselmes/clact/build/container@main
  with:
    tag: my-app
    publish: true
```

Or use the reusable workflows below, which wrap these actions with a hardened
runner and standard checkout:

```yaml
jobs:
  container:
    uses: anselmes/cicd/.github/workflows/container.yml@main
    with:
      tag: my-app
      publish: true
    permissions:
      contents: read
      packages: write
      id-token: write

  chart:
    uses: anselmes/cicd/.github/workflows/chart.yml@main
    with:
      context: charts/my-app
      publish: true
    permissions:
      contents: read
      packages: write
```

## Configuration

### Environment Setup

- Copy [`.devcontainer/`](.devcontainer/) to your project for consistent development environments
- Use [`scripts/configure.sh`](scripts/configure.sh) to set up your development environment
- Customize [`scripts/environment.sh`](scripts/environment.sh) and [`scripts/aliases.sh`](scripts/aliases.sh) as needed

### Security Configuration

- Set up required secrets in your repository settings
- Configure branch protection rules
- Enable security features like Dependency Graph and Secret Scanning

### Code Quality Tools

- [`.trunk/trunk.yaml`](.trunk/trunk.yaml) is the single source of linter configuration — actionlint, checkov, hadolint, markdownlint, osv-scanner, semgrep, shellcheck, shfmt, trivy, trufflehog, yamllint, and zizmor all run through it, so no separate per-tool config files are needed
- Set up [`.pre-commit-config.yaml`](.pre-commit-config.yaml) for pre-commit hooks

## Scripts

- [`configure.sh`](scripts/configure.sh) - Development environment setup
- [`configure-gh-actions-runner.sh`](scripts/configure-gh-actions-runner.sh) - Self-hosted runner setup
- [`delete-gh-actions-cache.sh`](scripts/delete-gh-actions-cache.sh) - GitHub Actions cache cleanup
- [`environment.sh`](scripts/environment.sh) - Environment variables configuration
- [`aliases.sh`](scripts/aliases.sh) - Shell aliases setup

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## Security

For security concerns, please see [SECURITY.md](SECURITY.md) for our security policy and reporting procedures.

## License

This project is licensed under the GNU General Public License v3.0 - see
[LICENSE](LICENSE) for details.
