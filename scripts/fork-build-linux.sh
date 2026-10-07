#!/usr/bin/env bash
# Build the fork's Linux AppImage with updates pointed at the fork (see FORK.md).
set -euo pipefail
version="${1:?usage: $0 <version, e.g. 0.0.45>}"
cd "$(dirname "$0")/.."
# A shell inside a running T3 server inherits these; they would aim the build at it.
unset T3CODE_HOST T3CODE_HOME T3CODE_PORT
[ -f .env.local ] || { echo ".env.local with the public client config is missing (see FORK.md)" >&2; exit 1; }
export T3CODE_DESKTOP_UPDATE_REPOSITORY=aidenwboudr/t3code
export T3CODE_DESKTOP_VERSION="$version"
export T3CODE_DESKTOP_OUTPUT_DIR="${T3CODE_DESKTOP_OUTPUT_DIR:-$PWD/release}"
pnpm install --frozen-lockfile
pnpm dist:desktop:linux
