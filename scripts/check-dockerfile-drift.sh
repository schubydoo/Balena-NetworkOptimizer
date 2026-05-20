#!/usr/bin/env bash
# Drift-check between network-optimizer/Dockerfile.template and
# network-optimizer/Dockerfile.ghcr.
#
# These two files must stay byte-identical except in three sanctioned
# divergent regions where Dockerfile.ghcr cross-builds on BUILDPLATFORM
# (the GHCR mirror runs under buildx; balena's classic builder cannot —
# see CLAUDE.md gotcha #7 for the full rationale):
#
#   1. The file-header block (everything before "# --- Stage 0:").
#      Each file's header legitimately describes its own role.
#   2. Any region wrapped in "# DRIFT-ALLOWED: BEGIN" / "# DRIFT-ALLOWED: END"
#      comment fences. Today these wrap Stage 1's .NET FROM, the whole
#      go-build stage, and the whole iperf-build stage.
#
# This script normalizes both files (replacing the sanctioned regions
# with placeholder tokens), then runs `diff -u`. Non-zero exit on any
# drift outside the sanctioned regions.
#
# Run from the repo root:  ./scripts/check-dockerfile-drift.sh

set -euo pipefail

TEMPLATE="network-optimizer/Dockerfile.template"
GHCR="network-optimizer/Dockerfile.ghcr"

normalize() {
    awk '
        BEGIN { in_fence = 0; header_done = 0 }

        # Phase 1: replace the pre-Stage-0 file header with one placeholder.
        # Each Dockerfile legitimately describes its own purpose at the top,
        # so this region is expected to differ.
        !header_done {
            if (/^# --- Stage 0:/) {
                print "<<HEADER>>"
                print
                header_done = 1
                next
            }
            next
        }

        # Phase 2: collapse each DRIFT-ALLOWED fence to a single placeholder
        # so fence-sizes can differ between the two files (Stage 1 fence is
        # ~2 lines in template, ~16 lines in ghcr).
        /^# DRIFT-ALLOWED: BEGIN/ {
            in_fence = 1
            print "<<DRIFT-ALLOWED>>"
            next
        }
        /^# DRIFT-ALLOWED: END/ {
            in_fence = 0
            next
        }
        in_fence { next }

        # Phase 3: strip trailing whitespace; print.
        { sub(/[ \t]+$/, ""); print }

        END {
            if (in_fence) {
                print "ERROR: unclosed DRIFT-ALLOWED fence" > "/dev/stderr"
                exit 1
            }
        }
    ' "$1"
}

if [ ! -f "$TEMPLATE" ] || [ ! -f "$GHCR" ]; then
    echo "ERROR: expected both Dockerfiles to exist:" >&2
    echo "  $TEMPLATE" >&2
    echo "  $GHCR" >&2
    exit 2
fi

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

normalize "$TEMPLATE" > "$TMPDIR/template.norm"
normalize "$GHCR"     > "$TMPDIR/ghcr.norm"

if diff -u "$TMPDIR/template.norm" "$TMPDIR/ghcr.norm" > "$TMPDIR/diff" 2>&1; then
    echo "OK: $TEMPLATE and $GHCR match outside sanctioned regions."
    exit 0
fi

cat <<EOF
DRIFT DETECTED between Dockerfile.template and Dockerfile.ghcr outside
the sanctioned divergent regions.

If the drift is INTENTIONAL (a new cross-build-only optimization), wrap
the differing lines in BOTH files with:

    # DRIFT-ALLOWED: BEGIN  <short reason>
    ...your divergent lines...
    # DRIFT-ALLOWED: END

then re-run this check. Update CLAUDE.md gotcha #7 to record the new
sanctioned region.

If the drift is UNINTENTIONAL (e.g., Renovate updated one file but not
the other, or a manual edit landed in only one), apply the change to
the other file too so the shared body stays in sync.

Drift diff (normalized files):
----------------------------------------
EOF
cat "$TMPDIR/diff"
echo "----------------------------------------"
exit 1
