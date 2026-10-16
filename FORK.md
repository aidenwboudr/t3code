# aidenwboudr/t3code

A personal fork of [pingdotgg/t3code](https://github.com/pingdotgg/t3code) that renders
Mermaid diagrams and LaTeX math in chat. Branch `aiden` is the fork's base: an upstream
release tag plus the commits below. `main` mirrors upstream and is not used.

## What it adds on top of the release

| Upstream  | What                                                            | Status upstream (2026-10-16)                   |
| --------- | --------------------------------------------------------------- | ---------------------------------------------- |
| #14574    | LaTeX math (`$…$`, `$$…$$`, `\(…\)`, `\[…\]`) via KaTeX         | open; carried at head `2d2a16f`                |
| #16198    | Math labels inside Mermaid diagrams                             | open; carried at head `16f2647`                |
| #18308    | Finished Mermaid blocks render while a reply is still streaming | open (resubmits closed #16221); head `100f219` |
| #16249    | Copying a diagram copies its Mermaid source                     | open; carried at head `85382ed`                |
| fork only | **Render math** defaults to on (upstream: off)                  | —                                              |

Base: **v0.1.0**. Mermaid diagrams themselves (#15067) shipped upstream in v0.1.0, so the
fork no longer carries them. The fix that keeps `` `$HOME` `` as code after an unmatched `$`
started here and is now part of #14574.

Settings → Appearance → **Render math** still turns math off.

## Build and install (Linux AppImage)

Needs Node 24, pnpm 11 (corepack), cargo and ImageMagick. The script reads the public
client config the official builds ship with (Clerk key, relay URL, `T3CODE_*` names) from
`~/.config/t3code-fork/public.env`; copy the values out of an official release's
`app.asar` if it is missing. Don't put them in `.env.local`: the web tests read that file.

```sh
scripts/fork-build-linux.sh 0.1.0    # version to stamp; writes release/*.AppImage
```

The build points the in-app updater at this fork's GitHub releases
(`T3CODE_DESKTOP_UPDATE_REPOSITORY`), so upstream releases never replace it. Publish a
fork release by attaching the AppImage plus `latest-linux.yml` from the output dir.

## Moving to a new upstream release

1. `git fetch upstream --tags` and check which PRs above the new tag already contains.
2. `git switch -c claude/rebase-vX vX`, then apply each still-open PR's current head
   (`git fetch upstream pull/N/head`, `git diff upstream/main...FETCH_HEAD | git apply -3`)
   and re-apply the fork-only commit.
3. Test (`apps/web`: `pnpm run typecheck`, `pnpm run test`), build, check a thread with a
   diagram and a formula, then PR into `aiden`.

Once upstream ships math and the Mermaid fixes in a stable release, this fork has
nothing left to add: switch back to the official app.
