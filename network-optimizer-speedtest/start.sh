#!/bin/sh
# balena container entrypoint wrapper for the speedtest service.
# Applies defaults matching upstream's docker-compose.prod.yml, then
# echoes runtime context for troubleshooting, then exec's upstream's
# openspeedtest entrypoint which finishes nginx setup and starts it.
set -e

# --- Defaults (match upstream's docker-compose.prod.yml fallbacks)
: "${TZ:=America/Chicago}"
: "${OPENSPEEDTEST_PORT:=3005}"
: "${OPENSPEEDTEST_HTTPS:=false}"
: "${OPENSPEEDTEST_HTTPS_PORT:=443}"
export TZ OPENSPEEDTEST_PORT OPENSPEEDTEST_HTTPS OPENSPEEDTEST_HTTPS_PORT

echo "=== network-optimizer-speedtest starting ==="
echo "  date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "  arch: $(uname -m)"
echo "  user: $(id -un) (uid=$(id -u))"
echo "  env :"
env | sort | sed 's/^/    /'
echo "==========================================="

exec /docker-entrypoint.sh "$@"
