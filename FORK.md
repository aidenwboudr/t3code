# aidenwboudr/t3code

A personal fork of [pingdotgg/t3code](https://github.com/pingdotgg/t3code) that renders
Mermaid diagrams and LaTeX math in chat. Branch `aiden` is the fork's base: an upstream
release tag plus the commits below. `main` mirrors upstream and is not used.

## What it adds on top of the release

Base: `v0.0.46-nightly.20261007.2761`. Mermaid diagrams (#15067) are upstream since that tag,
so the fork no longer carries them.

| Upstream  | What                                                            | Status upstream (2026-10-07) |
| --------- | --------------------------------------------------------------- | ---------------------------- |
| #14574    | LaTeX math (`$…$`, `$$…$$`, `\(…\)`, `\[…\]`) via KaTeX         | open                         |
| #16198    | Math labels inside Mermaid diagrams                             | open                         |
| #16221    | Finished Mermaid blocks render while a reply is still streaming | open                         |
| #16249    | Copying a diagram copies its Mermaid source                     | open                         |
| fork only | **Render math** defaults to on (upstream: off)                  | —                            |
| fork only | A code span after an unmatched dollar sign stays code           | not reported                 |

Settings → Appearance → **Render math** still turns math off.

## Build and install (Linux AppImage)

Needs Node 24, pnpm 11 (corepack), cargo and ImageMagick. The script reads the public
client config the official builds ship with (Clerk key, relay URL, `T3CODE_*` names) from
`~/.config/t3code-fork/public.env`; copy the values out of an official release's
`app.asar` if it is missing. Don't put them in `.env.local`: the web tests read that file.

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
