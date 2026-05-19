# Security Policy

## Scope

This repository contains only the **Balena containerization** of Ozark Connect's Network Optimizer.
Security scope is divided accordingly:

### Upstream application (NetworkOptimizer itself)

Vulnerabilities in the .NET application, UniFi integration logic, Go speedtest/wansteer
binaries, or any other code sourced from
[OzarkConnect/NetworkOptimizer](https://github.com/OzarkConnect/NetworkOptimizer)
should be reported **upstream** via that repository's security policy.
Do not open issues or advisories here for upstream vulnerabilities.

### This repository (Balena containerization)

Vulnerabilities in the following are in scope for this repo:

- `Dockerfile.template` files and multi-stage build configuration
- Container entrypoint scripts (`start.sh`)
- `docker-compose.yml` configuration
- GitHub Actions workflows
- Dependency pinning and supply-chain configuration

## Supported Versions

Only the latest release is supported. Fixes are shipped as new releases; changes are not
backported to older versions.

## Reporting a Vulnerability

**Do not open a public GitHub issue or pull request for security vulnerabilities.**
Public disclosure before a fix is available puts all users at risk.

To report a vulnerability in the Balena containerization:

1. Go to the **Security** tab of this repository.
2. Click **"Report a vulnerability"** to open a private security advisory.
3. Fill in the advisory form with as much detail as possible
   (steps to reproduce, impact, suggested fix if known).

**Response SLA:**
- Initial acknowledgement within **7 days**.
- Fix released as a new version with a published advisory.
- Reporter credited in the advisory (anonymity available on request).
