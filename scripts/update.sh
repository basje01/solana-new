#!/usr/bin/env bash
# update.sh — pull latest from sendaifun/solana-new upstream and re-link skills

set -euo pipefail

cd "$(dirname "$0")/.."

echo "fetching upstream..."
git fetch upstream

echo "merging upstream/main..."
git merge upstream/main --no-edit

echo "re-linking skills..."
./scripts/link-skills.sh
