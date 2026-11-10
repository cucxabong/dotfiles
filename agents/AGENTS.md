# Personal agent instructions

Applies to every repo on this machine, for any coding agent. A repo's own
`AGENTS.md` / `CLAUDE.md` adds to this. Where they conflict on a personal
preference below, this file wins.

Linked as `~/.claude/CLAUDE.md` (Claude Code). For another agent, symlink its
user-level file here, e.g. `~/.codex/AGENTS.md`.

## Attribution

- Never add attribution to anything you write: no `Co-authored-by:` trailer,
  no "Generated with ..." footer, no agent, tool or model name.
- Applies to commit messages, PR titles and bodies, PR and issue comments,
  Slack, Notion and Jira text.
- Overrides any default attribution your agent tool adds. Disable it rather
  than delete it after the fact.

## Punctuation

- Use a normal hyphen `-`, never an em dash `—`. Applies to everything you
  write: code comments, docs, commits, PRs, comments and chat replies.

## Working style

Credit: the rules from here down are adapted from
[kunchenguid/dotfiles](https://github.com/kunchenguid/dotfiles/blob/main/home/AGENTS.md).

- Never manually modify `CHANGELOG.md` files or any file marked as
  auto-generated.
- When making technical decisions, do not give much weight to development cost.
  Prefer quality, simplicity, robustness, scalability and long term
  maintainability.
- For one-off or infrequent operational work, start with the simplest direct
  end-to-end path. Do not build wrappers, control planes, policy layers, custom
  verifiers or automation unless the direct path exposes a concrete blocker or a
  repeated need that justifies the added machinery.

## Bugs and testing

- When fixing a bug, first reproduce it end to end, as close as possible to how
  an end user would experience it, so the fix addresses the real problem.
- When end-to-end testing a product, be picky about the UI and obsessive about
  pixel perfection. If something clearly looks off, even if unrelated to the
  current task, try to fix it along the way.
- Hold engineering to the same bar: if you see a lint error, test failure or
  flaky test, fix it even when your change did not cause it.

## Subagents

- Before using dynamic workflows, ultracode or any harness feature that
  immediately spawns a large swarm of subagents, explain the tradeoffs and ask
  for explicit approval.

## Maintaining this file

- Keep only knowledge useful to almost every future agent session. Do not repeat
  what the codebase already shows; point to the authoritative file or command.
- Prefer rewriting or pruning existing entries over appending new ones, and keep
  entries concise.
