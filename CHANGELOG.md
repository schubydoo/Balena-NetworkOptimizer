# Changelog

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
