#!/usr/bin/env bash
# Build the fork's Linux AppImage with updates pointed at the fork (see FORK.md).
set -euo pipefail
version="${1:?usage: $0 <version, e.g. 0.0.45>}"
cd "$(dirname "$0")/.."
# A shell inside a running T3 server inherits these; they would aim the build at it.
unset T3CODE_HOST T3CODE_HOME T3CODE_PORT T3_BOOT_SERVICE_UNIT T3_SERVICE_LAUNCHER_CONTEXT
# Public client config of the official builds (see FORK.md). Kept out of the repo's
# .env.local, which the web tests would also pick up.
config="${T3_FORK_PUBLIC_ENV:-$HOME/.config/t3code-fork/public.env}"
[ -f "$config" ] || { echo "missing $config (see FORK.md)" >&2; exit 1; }
set -a; . "$config"; set +a
export T3CODE_DESKTOP_UPDATE_REPOSITORY=aidenwboudr/t3code
export T3CODE_DESKTOP_VERSION="$version"
export T3CODE_DESKTOP_OUTPUT_DIR="${T3CODE_DESKTOP_OUTPUT_DIR:-$PWD/release}"
# Start empty: a leftover latest-linux.yml from an older build would ship with this one.
rm -rf "$T3CODE_DESKTOP_OUTPUT_DIR"
pnpm install --frozen-lockfile
pnpm dist:desktop:linux
