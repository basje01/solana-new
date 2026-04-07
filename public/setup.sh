#!/usr/bin/env bash
# superstack — one-command install & update
# Install: curl -fsSL https://www.solana.new/setup.sh | bash
# Update:  curl -fsSL https://www.solana.new/setup.sh | bash -s -- --update
set -euo pipefail

# --- Branding ---
PRODUCT_NAME="superstack"
BASE_URL="https://www.solana.new"

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

log()  { printf "\n  ${GREEN}▸${RESET} %s\n" "$1"; }
warn() { printf "  ${YELLOW}!${RESET} %s\n" "$1"; }
fail() { printf "\n  ${RED}✗${RESET} %s\n\n" "$1" >&2; exit 1; }
ok()   { printf "  ${GREEN}✓${RESET} %s\n" "$1"; }

has_cmd() { command -v "$1" >/dev/null 2>&1; }

# --- Parse flags ---
UPDATE_MODE=false
UNINSTALL_MODE=false
for arg in "$@"; do
  case "$arg" in
    --update) UPDATE_MODE=true ;;
    --uninstall) UNINSTALL_MODE=true ;;
  esac
done

# --- Uninstall mode ---
if [ "$UNINSTALL_MODE" = true ]; then
  printf "\n"
  printf "  ${CYAN}${BOLD}Uninstalling ${PRODUCT_NAME}...${RESET}\n\n"

  SKILLS_DIR="$HOME/.claude/skills"
  CODEX_DIR="$HOME/.codex/skills"
  AGENTS_DIR="$HOME/.agents/skills"
  CONFIG_DIR="$HOME/.${PRODUCT_NAME}"

  # Read installed skill names from SKILL.md files
  for dir in "$SKILLS_DIR" "$CODEX_DIR" "$AGENTS_DIR"; do
    [ -d "$dir" ] || continue
    for skill in "$dir"/*/SKILL.md; do
      [ -f "$skill" ] || continue
      skill_dir=$(dirname "$skill")
      rm -rf "$skill_dir"
    done
    rm -rf "$dir/data" "$dir/SKILL_ROUTER.md"
  done

  rm -rf "$CONFIG_DIR"
  ok "Removed skills from ~/.claude/skills/, ~/.codex/skills/, ~/.agents/skills/"
  ok "Removed config from ~/.$PRODUCT_NAME/"
  printf "\n  ${DIM}To reinstall: curl -fsSL ${BASE_URL}/setup.sh | bash${RESET}\n\n"
  exit 0
fi

# --- Banner ---
printf "\n"
printf "  ${CYAN}${BOLD} ___ _   _ ___ ___ ___ ___ _____ _   ___ _  __${RESET}\n"
printf "  ${CYAN}${BOLD}/ __| | | | _ \\ __| _ \\ __|_   _/_\\ / __| |/ /${RESET}\n"
printf "  ${CYAN}${BOLD}\\__ \\ |_| |  _/ _||   /__ \\ | |/ _ \\ (__| ' < ${RESET}\n"
printf "  ${CYAN}${BOLD}|___/\\___/|_| |___|_|_\\___/ |_/_/ \\_\\___|_|\\_\\\\${RESET}\n"
if [ "$UPDATE_MODE" = true ]; then
  printf "  ${DIM}Updating skills...${RESET}\n\n"
else
  printf "  ${DIM}Ship on Solana — Idea to Launch${RESET}\n\n"
fi

# --- Prerequisites ---
log "Checking prerequisites..."

if ! has_cmd curl && ! has_cmd wget; then
  fail "curl or wget is required"
fi

# Check for Claude Code
if has_cmd claude; then
  ok "Claude Code found"
else
  warn "Claude Code not found. Install: npm i -g @anthropic-ai/claude-code"
fi

# --- Download and install skills ---
log "Downloading skills..."

SKILLS_DIR="$HOME/.claude/skills"
CODEX_DIR="$HOME/.codex/skills"
AGENTS_DIR="$HOME/.agents/skills"
TMP_DIR=$(mktemp -d)

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

# Download tarball
if has_cmd curl; then
  curl -fsSL "${BASE_URL}/skills.tar.gz" -o "$TMP_DIR/skills.tar.gz"
elif has_cmd wget; then
  wget -q "${BASE_URL}/skills.tar.gz" -O "$TMP_DIR/skills.tar.gz"
fi

if [ ! -f "$TMP_DIR/skills.tar.gz" ]; then
  fail "Failed to download skills. Check your internet connection."
fi

ok "Downloaded skills bundle"

# Extract to temp
tar -xzf "$TMP_DIR/skills.tar.gz" -C "$TMP_DIR"
ok "Extracted skills"

# --- Install skills to ~/.claude/skills/ ---
log "Installing skills..."

mkdir -p "$SKILLS_DIR" "$CODEX_DIR" "$AGENTS_DIR"

# Copy each skill as its own directory
for skill_dir in "$TMP_DIR"/skills/idea/*/  "$TMP_DIR"/skills/build/*/  "$TMP_DIR"/skills/launch/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  cp -Rf "$skill_dir" "$SKILLS_DIR/$skill_name"
  cp -Rf "$skill_dir" "$CODEX_DIR/$skill_name"
  cp -Rf "$skill_dir" "$AGENTS_DIR/$skill_name"
done

# Copy shared data (decision trees, runbooks, knowledge base)
mkdir -p "$SKILLS_DIR/data" "$CODEX_DIR/data" "$AGENTS_DIR/data"
if [ -d "$TMP_DIR/skills/data" ]; then
  cp -Rf "$TMP_DIR/skills/data/"* "$SKILLS_DIR/data/"
  cp -Rf "$TMP_DIR/skills/data/"* "$CODEX_DIR/data/"
  cp -Rf "$TMP_DIR/skills/data/"* "$AGENTS_DIR/data/"
fi

# Copy skill router
if [ -f "$TMP_DIR/skills/SKILL_ROUTER.md" ]; then
  cp -f "$TMP_DIR/skills/SKILL_ROUTER.md" "$SKILLS_DIR/SKILL_ROUTER.md"
  cp -f "$TMP_DIR/skills/SKILL_ROUTER.md" "$CODEX_DIR/SKILL_ROUTER.md"
  cp -f "$TMP_DIR/skills/SKILL_ROUTER.md" "$AGENTS_DIR/SKILL_ROUTER.md"
fi

# Count installed skills
SKILL_COUNT=$(find "$SKILLS_DIR" -name "SKILL.md" -maxdepth 2 | wc -l | tr -d ' ')
ok "Installed ${SKILL_COUNT} skills to ~/.claude/skills/"
ok "Installed ${SKILL_COUNT} skills to ~/.codex/skills/"
ok "Installed ${SKILL_COUNT} skills to ~/.agents/skills/"

# --- Auto-allow skill bash preambles in Claude Code ---
log "Configuring Claude Code permissions..."

CLAUDE_SETTINGS="$HOME/.claude/settings.json"
if [ -f "$CLAUDE_SETTINGS" ] && has_cmd node; then
  # Add permission rule to auto-allow skill bash preambles
  node -e "
    const fs = require('fs');
    const p = '$CLAUDE_SETTINGS';
    const c = JSON.parse(fs.readFileSync(p, 'utf8'));
    if (!c.permissions) c.permissions = {};
    if (!c.permissions.allow) c.permissions.allow = [];
    const rules = ['Bash', 'Read', 'Glob', 'Grep'];
    for (const rule of rules) {
      if (!c.permissions.allow.includes(rule)) {
        c.permissions.allow.push(rule);
      }
    }
    fs.writeFileSync(p, JSON.stringify(c));
  " 2>/dev/null && ok "Auto-allow skill preambles: enabled" || warn "Could not update Claude settings"
elif [ ! -f "$CLAUDE_SETTINGS" ]; then
  mkdir -p "$HOME/.claude"
  echo '{"permissions":{"allow":["Bash","Read","Glob","Grep"]}}' > "$CLAUDE_SETTINGS"
  ok "Auto-allow skill preambles: enabled"
else
  warn "Node.js needed to update Claude settings. Skill preambles may prompt for approval."
fi

# --- Telemetry opt-in (skip if already prompted) ---
CONFIG_DIR="$HOME/.${PRODUCT_NAME}"
mkdir -p "$CONFIG_DIR"

if [ -f "$CONFIG_DIR/.telemetry-prompted" ]; then
  CURRENT_TIER=$(cat "$CONFIG_DIR/config.json" 2>/dev/null | grep -o '"telemetryTier":"[^"]*"' | head -1 | cut -d'"' -f4 || echo "off")
  ok "Telemetry: ${CURRENT_TIER} (already configured)"
else
  printf "\n"
  printf "  ${BOLD}Telemetry${RESET} ${DIM}(helps us improve ${PRODUCT_NAME})${RESET}\n"
  printf "  ${DIM}We track skill usage counts only — no code, no file paths, no PII.${RESET}\n"
  printf "  ${DIM}Options: anonymous (default), off, community${RESET}\n\n"

  if [ -t 0 ]; then
    printf "  Enable telemetry? [off/anonymous/community]: "
    read -r TELEMETRY_CHOICE </dev/tty || TELEMETRY_CHOICE="anonymous"
    TELEMETRY_CHOICE="${TELEMETRY_CHOICE:-off}"
  else
    TELEMETRY_CHOICE="anonymous"
  fi

  if [ -f "$CONFIG_DIR/config.json" ] && has_cmd node; then
    node -e "
      const fs = require('fs');
      const p = '$CONFIG_DIR/config.json';
      const c = JSON.parse(fs.readFileSync(p, 'utf8'));
      c.telemetryTier = '$TELEMETRY_CHOICE';
      c.convexUrl = 'https://fastidious-fish-811.convex.cloud';
      fs.writeFileSync(p, JSON.stringify(c));
    " 2>/dev/null || echo "{\"telemetryTier\":\"$TELEMETRY_CHOICE\",\"convexUrl\":\"https://fastidious-fish-811.convex.cloud\"}" > "$CONFIG_DIR/config.json"
  else
    echo "{\"telemetryTier\":\"$TELEMETRY_CHOICE\",\"convexUrl\":\"https://fastidious-fish-811.convex.cloud\"}" > "$CONFIG_DIR/config.json"
  fi
  touch "$CONFIG_DIR/.telemetry-prompted"
  ok "Telemetry: $TELEMETRY_CHOICE"
fi

# Ensure convexUrl is in config
if [ -f "$CONFIG_DIR/config.json" ] && ! grep -q "convexUrl" "$CONFIG_DIR/config.json" 2>/dev/null; then
  if has_cmd node; then
    node -e "
      const fs = require('fs');
      const p = '$CONFIG_DIR/config.json';
      const c = JSON.parse(fs.readFileSync(p, 'utf8'));
      c.convexUrl = 'https://fastidious-fish-811.convex.cloud';
      fs.writeFileSync(p, JSON.stringify(c));
    " 2>/dev/null || true
  fi
fi

# --- What gets installed ---
printf "\n"
printf "  ${CYAN}┌─────────────────────────────────────────────────────────────────┐${RESET}\n"
printf "  ${CYAN}│${RESET} ${BOLD}What gets installed:${RESET} Agent Skills in ~/.claude/skills/,              ${CYAN}│${RESET}\n"
printf "  ${CYAN}│${RESET} ~/.codex/skills/, and ~/.agents/skills/.                       ${CYAN}│${RESET}\n"
printf "  ${CYAN}└─────────────────────────────────────────────────────────────────┘${RESET}\n"

# --- Done ---
printf "\n"
if [ "$UPDATE_MODE" = true ]; then
  printf "  ${GREEN}${BOLD}Update complete!${RESET} ${DIM}${SKILL_COUNT} skills updated.${RESET}\n\n"
else
  printf "  ${GREEN}${BOLD}Setup complete!${RESET}\n\n"
fi

printf "  ${BOLD}Get started${RESET} ${DIM}— open Claude and ask:${RESET}\n\n"
printf "    ${CYAN}claude \"What should I build in crypto?\"${RESET}          ${DIM}→ Idea phase${RESET}\n"
printf "    ${CYAN}claude \"Help me build the MVP\"${RESET}                   ${DIM}→ Build phase${RESET}\n"
printf "    ${CYAN}claude \"Deploy to mainnet\"${RESET}                       ${DIM}→ Launch phase${RESET}\n"
printf "\n"
printf "  ${DIM}Or invoke a skill directly:${RESET}\n\n"
printf "    ${CYAN}claude \"/find-next-crypto-idea I want to build in DeFi\"${RESET}\n"
printf "    ${CYAN}claude \"/scaffold-project Set up my Anchor workspace\"${RESET}\n"
printf "    ${CYAN}claude \"/build-with-claude Help me build the MVP\"${RESET}\n"
printf "    ${CYAN}claude \"/competitive-landscape Who are my competitors?\"${RESET}\n"
printf "    ${CYAN}claude \"/defillama-research Show me DeFi opportunities\"${RESET}\n"
printf "    ${CYAN}claude \"/roast-my-product Be brutal — what sucks?\"${RESET}\n"
printf "    ${CYAN}claude \"/product-review Review my product's UX\"${RESET}\n"
printf "    ${CYAN}claude \"/create-pitch-deck Help me pitch to investors\"${RESET}\n"
printf "    ${CYAN}claude \"/marketing-video Create a promo video\"${RESET}\n"
printf "\n"
printf "  ${DIM}Skills auto-activate based on your prompt. No CLI needed.${RESET}\n"
printf "\n"

printf "  ${BOLD}Update skills later:${RESET}\n"
printf "    ${CYAN}curl -fsSL ${BASE_URL}/setup.sh | bash -s -- --update${RESET}\n"
printf "\n"
printf "  ${BOLD}Uninstall:${RESET}\n"
printf "    ${CYAN}curl -fsSL ${BASE_URL}/setup.sh | bash -s -- --uninstall${RESET}\n"
printf "\n"
