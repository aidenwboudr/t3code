# aidenwboudr/t3code (retired)

A personal fork of [pingdotgg/t3code](https://github.com/pingdotgg/t3code) that rendered
Mermaid diagrams and LaTeX math in chat. **It was retired on 2026-10-21**: upstream v0.1.1
renders both itself, so the laptop goes back to the official app and its upstream updates.
The last fork release is `v0.1.0-aiden.1`, and no more will be published.

## Why retiring was safe

Everything the fork carried on top of v0.1.0 is in upstream v0.1.1:

| Upstream  | What                                                            | Landed in v0.1.1 as                 |
| --------- | --------------------------------------------------------------- | ----------------------------------- |
| #14574    | LaTeX math (`$…$`, `$$…$$`, `\(…\)`, `\[…\]`) via KaTeX         | superseded by #18735 (merged 10-19) |
| #16198    | Math labels inside Mermaid diagrams                             | merged 10-18                        |
| #18308    | Finished Mermaid blocks render while a reply is still streaming | merged 10-19                        |
| #16249    | Copying a diagram copies its Mermaid source                     | merged 10-20                        |
| fork only | `` `$HOME` `` stays code after an unmatched `$`                 | covered by #18735's own tests       |
| fork only | **Render math** defaults to on                                  | not upstream: math is opt-in        |

The upstream v0.1.1 server bundle passed the same end-to-end render check the fork used
(4 formulas, 2 diagrams, `` `$HOME` `` as code, prices as text) with Render math turned on.

Math is off by default upstream: turn on Settings → Appearance → **Render math**.

## Going back to a fork

`scripts/fork-build-linux.sh <version>` still builds a fork AppImage whose updater reads
this repo's releases. To revive the fork, rebase `aiden` onto the upstream tag, re-apply
what upstream lacks, build, and publish `v<version>-aiden.1` with the AppImage plus
`latest-linux.yml`. The build needs Node 24, pnpm 11 (corepack), cargo, ImageMagick, and
the public client config in `~/.config/t3code-fork/public.env`.
