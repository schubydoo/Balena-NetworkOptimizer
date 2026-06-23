# Changelog

## v0.7.0\n- chore(deps): update golang image
- chore(deps): update balena actions
- chore(deps): update github actions
- chore(deps): update docker/dockerfile docker tag to v1.25
- chore(deps): update security actions
- chore(deps): update upstream networkoptimizer

## v0.6.0\n- chore(deps): update pre-commit hooks to v10.5.0
- chore(deps): update upstream networkoptimizer to v1.20.4
- chore(deps): update balena actions to v2.3.0

## v0.5.0\n- chore(deps): update security actions
- chore: stop Renovate PRs auto-requesting code-owner review
- chore(deps): update golang image
- chore(deps): update dotnet images
- chore(deps): update github actions to v6.0.3
- chore(deps): update debian:bookworm-slim docker digest to 96e378d
- chore(deps): update upstream networkoptimizer to v1.19.5
- chore(deps): update balena actions to v2.2.13
- chore(deps): update upstream networkoptimizer to v1.19.2
- chore(deps): update golang image
- ci: validate inputs.version before using it in checkout ref
- ci: pass github/inputs context via env in balena-publish-block
- ci: remove StepSecurity harden-runner from all workflows
- chore(deps): update balena-io/deploy-to-balena-action action to v2.2.12
- chore(deps): update pre-commit hook pre-commit/mirrors-eslint to v10.4.1

## v0.4.1\n- chore(deps): update dependency ozark-connect/networkoptimizer to v1.17.18
- chore(deps): update docker/setup-qemu-action digest to 0611638

## v0.4.0\n- chore(deps): update dependency ozark-connect/networkoptimizer to v1.17.5
- chore(deps): update docker actions
- chore(deps): update dotnet images
- chore(deps): update security actions
- Mark drift-check script as executable in git tree
- Add Dockerfile drift-check CI
- Revert COPY --chmod=755 — balena's classic builder rejects it
- Consolidate Go stages, drop runtime rename dance, use COPY --chmod
- Bump tonistiigi/binfmt v8.1.5 -> v10.2.1 and let Renovate track it
- chore(deps): pin debian docker tag to 0104b33
- Cross-compile Go stages in Dockerfile.ghcr to avoid QEMU
- Cross-compile iperf3 in Dockerfile.ghcr to avoid QEMU emulation
- Revert "[StepSecurity] Apply security best practices"
- Retry apt install up to 3x in iperf-build stage
- [StepSecurity] Apply security best practices

## v0.3.0\n- chore(deps): pin golang docker tag to 91eda97
- chore(deps): pin dependencies
- chore(deps): pin dependencies
- Pin Docker base images by digest via Renovate
- Fix upstream repo URL typo: OzarkConnect → Ozark-Connect
- chore(deps): update docker/dockerfile docker tag to v1.24
- chore(workflows): Add Dockerfile.template to trivyignore for speedtest
- chore(deps): update dependency ozark-connect/networkoptimizer to v1.16.10
- chore(deps): update dependency esnet/iperf to v3.21
- Switch release.yml to manual workflow_dispatch + range-scan
- Map Renovate updates to Change-type trailers; cover Dockerfile.ghcr
- chore(deps): update dependency esnet/iperf to v3.21
- Suppress Trivy AVD-DS-0002 (intentional root-then-gosu init)
- Move the .NET cross-build to a GHCR-only Dockerfile; revert template
- Cross-build .NET stage on BUILDPLATFORM to fix GHCR arm/v7

## v0.2.2\n- Add HEALTHCHECK to speedtest container
- chore(deps): update pre-commit hooks
- chore(deps): update github/codeql-action action to v4
- chore(deps): update github actions
- chore(deps): update pre-commit hooks
- chore(deps): update golang docker tag to v1.26
- chore(config): migrate config renovate.json
- Pin older QEMU for GHCR multi-arch build (.NET arm/v7 SIGABRT)
- Drop package-lock.json handling from release.yml
- Renovate: track pre-commit, group harden-runner, drop deprecated matchPackagePatterns

## v0.2.1\n- Use WORKDIR instead of RUN cd for iperf3 build
- Add workflow_dispatch trigger to CodeQL
- Add actions language to CodeQL matrix
- Use javascript-typescript CodeQL language
- Harden CI: minimal release.yml token scope + balena API host allowlist
- [StepSecurity] Apply security best practices
- Add build-validation workflow as a reliable PR gate
- Restore category: trivy on Trivy SARIF upload
- Remove :maintainLockFilesWeekly from Renovate config
- Fix Renovate coverage gaps
- Add Renovate annotations for upstream version ARGs
- Align workflows with autohupr (A-F)
- Add job display names to Trivy and TruffleHog workflows
- Fix post-launch workflow and build failures
- Add full CI/CD pipeline and supply-chain security
- Optimize Dockerfile builds for better layer caching
- Promote to sw.block and move balena.yml to repo root
- Add Renovate for automated dependency updates
- Add security policy, code owners, PR template, and README credits
- Add package.json so balena assigns the correct release semver (#5)
- Trigger prod deploy on tag push, not release event (#4)

## v0.2.0
- Initial Balena port of Ozark Connect NetworkOptimizer
- Multi-arch source builds (amd64, arm64, armv7)
- Speedtest sidecar service (OpenSpeedTest)
- Healthcheck on the .NET API endpoint
- start.sh wrapper with env-var defaults and masked debug output
