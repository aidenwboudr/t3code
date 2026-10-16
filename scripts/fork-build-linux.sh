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
# The repo keeps a placeholder version; upstream's release CI stamps the real one into the
# server, web, desktop and contracts packages before building. Without it the app's own
# server and web client report the placeholder (v0.1.0-aiden.1 said 0.0.45), which breaks
# T3's client/server version checks. Put the placeholder back afterwards.
stamped=(apps/server/package.json apps/desktop/package.json apps/web/package.json packages/contracts/package.json)
trap 'git checkout -- "${stamped[@]}"' EXIT
node scripts/update-release-package-versions.ts "$version"
pnpm dist:desktop:linux
