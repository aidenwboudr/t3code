# aidenwboudr/t3code

A personal fork of [pingdotgg/t3code](https://github.com/pingdotgg/t3code) that renders
Mermaid diagrams and LaTeX math in chat. Branch `aiden` is the fork's base: an upstream
release tag plus the commits below. `main` mirrors upstream and is not used.

## What it adds on top of the release

| Upstream  | What                                                            | Status upstream (2026-10-07)                                |
| --------- | --------------------------------------------------------------- | ----------------------------------------------------------- |
| #15067    | Mermaid code fences render as diagrams                          | merged to `main` after v0.0.45, not yet in a stable release |
| #14574    | LaTeX math (`$…$`, `$$…$$`, `\(…\)`, `\[…\]`) via KaTeX         | open                                                        |
| #16198    | Math labels inside Mermaid diagrams                             | open                                                        |
| #16221    | Finished Mermaid blocks render while a reply is still streaming | open                                                        |
| #16249    | Copying a diagram copies its Mermaid source                     | open                                                        |
| fork only | **Render math** defaults to on (upstream: off)                  | —                                                           |

Settings → Appearance → **Render math** still turns math off.

## Build and install (Linux AppImage)

Needs Node 24, pnpm 11 (corepack), cargo and ImageMagick. `.env.local` holds the public
client config the official builds ship with (Clerk key, relay URL); copy it out of an
official release's `app.asar` if it is missing.

```sh
scripts/fork-build-linux.sh 0.0.45   # version to stamp; writes release/*.AppImage
```

The build points the in-app updater at this fork's GitHub releases
(`T3CODE_DESKTOP_UPDATE_REPOSITORY`), so upstream releases never replace it. Publish a
fork release by attaching the AppImage plus `latest-linux.yml` from the output dir.

## Moving to a new upstream release

1. `git fetch upstream --tags`
2. `git switch -c claude/rebase-vX aiden && git rebase --onto vX <old tag> claude/rebase-vX`,
   dropping any commit upstream has since merged.
3. Build, check a thread with a diagram and a formula, then PR into `aiden`.

Once upstream ships math and the Mermaid fixes in a stable release, this fork has
nothing left to add: switch back to the official app.
