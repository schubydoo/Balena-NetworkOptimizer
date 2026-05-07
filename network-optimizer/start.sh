#!/bin/sh
# balena container entrypoint wrapper for the network-optimizer service.
# 1. Applies fallback defaults matching upstream's docker-compose.prod.yml.
# 2. Maps upstream's friendly env-var names onto the .NET-config dotted forms
#    so balena variables match upstream's .env.example documentation.
# 3. Echoes runtime context (with sensitive vars masked) for troubleshooting.
# 4. Exec's upstream's entrypoint, which handles volume chowns and launches
#    the .NET app.
set -e

# --- Defaults (match upstream's docker-compose.prod.yml fallbacks)
: "${TZ:=America/Chicago}"
: "${BIND_LOCALHOST_ONLY:=false}"
: "${OPENSPEEDTEST_PORT:=3005}"
: "${OPENSPEEDTEST_HTTPS:=false}"
: "${OPENSPEEDTEST_HTTPS_PORT:=443}"
: "${IPERF3_SERVER_ENABLED:=false}"
: "${LOG_LEVEL:=Information}"
: "${APP_LOG_LEVEL:=Information}"
export TZ BIND_LOCALHOST_ONLY \
    OPENSPEEDTEST_PORT OPENSPEEDTEST_HTTPS OPENSPEEDTEST_HTTPS_PORT \
    IPERF3_SERVER_ENABLED LOG_LEVEL APP_LOG_LEVEL

# --- Upstream-friendly name → .NET config key mapping
# Set the .NET dotted form only if the dotted form isn't already set
# (operator-set wins over our derivation).
[ -z "$Iperf3Server__Enabled"              ] && export Iperf3Server__Enabled="$IPERF3_SERVER_ENABLED"
[ -z "$Logging__LogLevel__Default"         ] && export Logging__LogLevel__Default="$LOG_LEVEL"
[ -z "$Logging__LogLevel__NetworkOptimizer" ] && export Logging__LogLevel__NetworkOptimizer="$APP_LOG_LEVEL"

echo "=== network-optimizer starting ==="
echo "  date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "  arch: $(uname -m)"
echo "  user: $(id -un) (uid=$(id -u))"
echo "  env :"
env | sort | sed -E 's/^(APP_PASSWORD|DEMO_MODE_MAPPINGS|INFLUXDB_TOKEN)=.*/\1=***/' | sed 's/^/    /'
echo "==================================="

exec /entrypoint.sh "$@"
