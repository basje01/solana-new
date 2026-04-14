#!/usr/bin/env bash
# link-skills.sh — idempotently symlink superstack skills into ~/.claude/skills/
#
# For every skills/<phase>/<name>/SKILL.md, create ~/.claude/skills/<name>
# as a symlink to the fork path. Safe to re-run: skips correct symlinks,
# warns on collisions, never overwrites existing directories.

set -euo pipefail

FORK="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$HOME/.claude/skills"
mkdir -p "$DEST"

linked=0
skipped=0
collided=0

link_one() {
  local src="$1" target="$2"
  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$src" ]]; then
      skipped=$((skipped+1))
      return
    fi
    echo "WARN: $target already links to $current (expected $src)"
    collided=$((collided+1))
    return
  fi
  if [[ -e "$target" ]]; then
    echo "COLLISION: $target already exists (not a symlink), skipping"
    collided=$((collided+1))
    return
  fi
  ln -s "$src" "$target"
  linked=$((linked+1))
}

for phase in idea build launch; do
  phase_dir="$FORK/skills/$phase"
  [[ -d "$phase_dir" ]] || continue
  for skill_dir in "$phase_dir"/*/; do
    [[ -f "${skill_dir}SKILL.md" ]] || continue
    name="$(basename "$skill_dir")"
    link_one "${skill_dir%/}" "$DEST/$name"
  done
done

link_one "$FORK/skills/data" "$DEST/_superstack-data"
link_one "$FORK/skills/SKILL_ROUTER.md" "$DEST/_superstack-router.md"

echo
echo "superstack link summary: linked=$linked skipped=$skipped collided=$collided"

if [[ -x "$HOME/.claude/bin/skills" ]]; then
  echo
  echo "running skills lint..."
  "$HOME/.claude/bin/skills" lint || {
    echo "WARN: skills lint reported drift (see above)"
    exit 0
  }
fi
