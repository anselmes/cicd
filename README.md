# CICD - Comprehensive CI/CD Toolkit

A reusable CI/CD toolkit providing GitHub Actions workflows, development containers, and automation scripts for modern software development projects.

---

[![OpenSSF Scorecard][ossf-score-badge]][ossf-score-link]
[![Contiuos Integration][ci-badge]][ci-link]
[![Review][review-badge]][review-link]

[ossf-score-badge]: https://api.securityscorecards.dev/projects/github.com/anselmes/cicd/badge
[ossf-score-link]: https://securityscorecards.dev/viewer/?uri=github.com/anselmes/cicd
[ci-badge]: https://github.com/anselmes/cicd/actions/workflows/cicd.yml/badge.svg
[ci-link]: https://github.com/anselmes/cicd/actions/workflows/cicd.yml
[review-badge]: https://github.com/anselmes/cicd/actions/workflows/required/anselmes/cicd/.github/workflows/review.yml/badge.svg
[review-link]: https://github.com/anselmes/cicd/actions/workflows/required/anselmes/cicd/.github/workflows/review.yml

---

## Features

### 🚀 GitHub Actions Workflows
- **Continuous Integration**: Automated builds, tests, and security scanning
- **Code Review**: Automated PR review with linting, security scanning, and dependency analysis
- **Security**: Trivy vulnerability scanning, Scorecard analysis, and GitGuardian secret detection
- **Bot Automation**: Dependabot integration with auto-merge for patch updates
- **Cleanup**: Automated cache cleanup and stale issue management

### 🛠️ Reusable Actions
- **Container Builds**: Multi-platform Docker image building with SBOM generation
- **Language Builds**: Support for Swift, Rust, and Go projects
- **Helm Charts**: Chart testing, packaging, and publishing
- **Linux Builds**: Kernel and Ubuntu image building (planned)

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
Reference the actions in your workflow:

```yaml
- name: Build Container
  uses: anselmes/cicd/.github/actions/docker@main
  with:
    tag: my-app
    publish: true
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
- Copy relevant configuration files (`.yamllint.yaml`, `.hadolint.yaml`, etc.)
- Customize [`.trunk/trunk.yaml`](.trunk/trunk.yaml) for your project's needs
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

Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
