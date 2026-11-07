#!/usr/bin/env bash
# Symlink dotfiles from this repo into $HOME.
# Existing files that are not already our symlink are moved to <name>.bak.<timestamp>.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# repo path -> target path
LINKS=(
  "tmux/tmux.conf:$HOME/.tmux.conf"
  "wezterm/wezterm.lua:$HOME/.wezterm.lua"
  "ccstatusline/settings.json:$HOME/.config/ccstatusline/settings.json"
  "agents/AGENTS.md:$HOME/.agents/AGENTS.md"
  "agents/AGENTS.md:$HOME/.claude/CLAUDE.md"
  "claude/bin/cc-spend.sh:$HOME/.claude/bin/cc-spend.sh"
  "starship/starship.toml:$HOME/.config/starship.toml"
)

link() {
  local src="$DOTFILES/$1" dst="$2"

  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "ok      $dst"
    return
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    local backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$backup"
    echo "backup  $dst -> $backup"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "link    $dst -> $src"
}

for entry in "${LINKS[@]}"; do
  link "${entry%%:*}" "${entry#*:}"
done
