# Balena-NetworkOptimizer

[![balena deploy status](https://img.shields.io/github/actions/workflow/status/schubydoo/Balena-NetworkOptimizer/balena-pr.yml?label=balena%20build)](https://github.com/schubydoo/Balena-NetworkOptimizer/actions/workflows/balena-pr.yml)
[![Latest release](https://img.shields.io/github/v/release/schubydoo/Balena-NetworkOptimizer)](https://github.com/schubydoo/Balena-NetworkOptimizer/releases)
[![License](https://img.shields.io/badge/license-BSL%201.1-blue)](LICENSE)

A [balenaOS](https://www.balena.io/os) port of
[Ozark Connect's Network Optimizer](https://github.com/OzarkConnect/NetworkOptimizer)
for UniFi consoles. Source-built per architecture (amd64, arm64, armv7) directly from
the upstream release tags.

## Services

| Service | Description | Port |
|---------|-------------|------|
| `network-optimizer` | .NET core app — WAN optimization, SQM, monitoring, iperf3 | 8042 |
| `network-optimizer-speedtest` | OpenSpeedTest web UI | 3005 |

## Quick start

Add to your `docker-compose.yml`:

```yaml
services:
  network-optimizer:
    build: ./network-optimizer
    network_mode: host
    restart: always
    volumes:
      - data:/app/data
      - ssh-keys:/app/ssh-keys
      - logs:/app/logs

  network-optimizer-speedtest:
    build: ./network-optimizer-speedtest
    restart: always
    ports:
      - "3005:3000"

volumes:
  data:
  ssh-keys:
  logs:
```

## Configuration

Set these as device or fleet variables in balenaCloud:

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `APP_HOST` | Yes | — | Hostname or IP of your UniFi console |
| `APP_USERNAME` | Yes | — | UniFi console username |
| `APP_PASSWORD` | Yes | — | UniFi console password |
| `TZ` | No | `America/Chicago` | Container timezone |
| `IPERF3_SERVER_ENABLED` | No | `false` | Enable iperf3 server on port 5201 |
| `LOG_LEVEL` | No | `Information` | Logging verbosity |
| `APP_LOG_LEVEL` | No | `Information` | Application-level logging verbosity |
| `OPENSPEEDTEST_PORT` | No | `3005` | External port for speedtest UI |

## Attribution

The core application is **Network Optimizer for UniFi** by
[Ozark Connect](https://ozarkconnect.net), licensed under the
[Business Source License 1.1](LICENSE).

- Upstream repository: [OzarkConnect/NetworkOptimizer](https://github.com/OzarkConnect/NetworkOptimizer)
- Commercial use (more than 3 sites) requires a separate license from Ozark Connect —
  contact [tj@ozarkconnect.net](mailto:tj@ozarkconnect.net)
- License converts to Apache 2.0 on 2028-01-01

This repository contains only the Balena containerization and is maintained separately.

## Security

See [SECURITY.md](SECURITY.md) for how to report vulnerabilities in the containerization
vs. the upstream application.
