# dotfiles

Personal configs, linked into `$HOME` by `install.sh`. Works on macOS and Linux.

## Install

```sh
git clone git@github.com:cucxabong/dotfiles.git
cd dotfiles
./install.sh
```

`install.sh` symlinks each entry in its `LINKS` list. A file already at a
target is moved to `<name>.bak.<timestamp>` first. Re-running it is safe:
links that are already correct are left alone.

The links point into this checkout, so keep the repo where you cloned it and
stay on a branch that has every linked file.

## What gets linked

| Repo file | Target |
|---|---|
| `tmux/tmux.conf` | `~/.tmux.conf` |
| `wezterm/wezterm.lua` | `~/.wezterm.lua` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `ccstatusline/settings.json` | `~/.config/ccstatusline/settings.json` |
| `claude/bin/cc-spend.sh` | `~/.claude/bin/cc-spend.sh` |
| `agents/AGENTS.md` | `~/.agents/AGENTS.md`, `~/.claude/CLAUDE.md` |

To add a config, put it under a folder named after the tool and add a
`"repo/path:$HOME/target"` line to `LINKS`.

## Dependencies

| Tool | Needed by | Notes |
|---|---|---|
| `bash` 3.2+ | `install.sh`, `cc-spend.sh` | The macOS system bash is enough. |
| [tmux](https://github.com/tmux/tmux) 3.5+ | `tmux.conf` | `extended-keys-format` needs 3.5. Older versions (Ubuntu 24.04 ships 3.4, Debian 12 ships 3.3a) report errors for those lines and load the rest. |
| `pbcopy`, `wl-copy` or `xclip` | tmux copy mode | Optional. With none installed, tmux copies through OSC 52, which needs a terminal that supports it, such as WezTerm. |
| [WezTerm](https://wezterm.org) | `wezterm.lua` | The Option-key settings only apply on macOS. |
| [Starship](https://starship.rs) | `starship.toml` | Add the init line for your shell yourself, e.g. `starship init fish \| source`. |
| [Claude Code](https://claude.com/claude-code) | `AGENTS.md`, statusline | |
| Node.js (`npx`) | ccstatusline, `cc-spend.sh` | Both are fetched with `npx` on each run: [ccstatusline](https://github.com/sirmalloc/ccstatusline) and [ccusage](https://github.com/ryoppippi/ccusage). |
| `jq` | `cc-spend.sh` | |

## Manual steps

Claude Code's `~/.claude/settings.json` is not in this repo. To turn on the
statusline, add:

```json
"statusLine": {
  "type": "command",
  "command": "npx -y ccstatusline@latest",
  "padding": 0
}
```

ccstatusline's settings editor may save `commandPath` as an absolute path.
Keep it as `$HOME/.claude/bin/cc-spend.sh` so it works on other machines.
