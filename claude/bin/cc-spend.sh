#!/usr/bin/env bash
# Prints today's and this month's Claude Code cost from ccusage, cached and refreshed in the background.
set -u

cache="${HOME}/.cache/cc-spend.txt"
lock="${HOME}/.cache/cc-spend.lock"
ttl=300

mkdir -p "$(dirname "$cache")"

refresh() {
  local today month
  today=$(npx -y ccusage@latest daily --json --since "$(date +%Y%m%d)" 2>/dev/null | jq -r '.totals.totalCost // 0') || return
  month=$(npx -y ccusage@latest monthly --json --since "$(date +%Y%m01)" 2>/dev/null | jq -r '.totals.totalCost // 0') || return
  printf 'Today: $%.2f | %s: $%.2f\n' "$today" "$(date +%b)" "$month" > "$cache.tmp" && mv "$cache.tmp" "$cache"
}

mtime() { stat -c %Y "$1" 2>/dev/null || stat -f %m "$1" 2>/dev/null || echo 0; } # GNU, then BSD

now=$(date +%s)
# A refresh killed mid-run leaves its lock behind; drop it once it is older than the TTL
if [[ -d "$lock" ]] && (( now - $(mtime "$lock") > ttl )); then
  rmdir "$lock" 2>/dev/null
fi

age=$(( now - $(mtime "$cache") ))
if (( age > ttl )) && mkdir "$lock" 2>/dev/null; then
  ( refresh; rmdir "$lock" ) </dev/null >/dev/null 2>&1 &
fi

cat "$cache" 2>/dev/null || echo "Today: … | Month: …"
