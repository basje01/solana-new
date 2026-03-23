# CLAUDE.md — solana.new

## What This Is

**solana.new** is a deterministic AI-native build system for Solana. Converts natural language prompts into validated Solana dApps through 5 built-in harnesses, a 59-repo catalog, 66 skills, and 49 MCP servers.

## Quick Reference

```bash
pnpm install          # install deps
pnpm build            # compile TypeScript → dist/
pnpm test             # run unit tests (planner + router)
pnpm dev              # run CLI via tsx (no build needed)
pnpm sync:solana-skills  # refresh solana-skills.json from solana.com
```

**CLI usage** (after build):
```bash
# Build pipeline
solana-new init
solana-new plan "Build a staking app" --agent codex
solana-new scaffold --out /tmp/my-app
solana-new run [--execute]
solana-new validate
solana-new doctor
solana-new repair [--stage validate] [--error "..."]

# Discover — search the ecosystem
solana-new search                  # universal interactive TUI
solana-new jupiter                 # shorthand — unknown commands become search
solana-new repos                   # interactive repo browser
solana-new skills                  # interactive skill browser
solana-new mcps                    # interactive MCP browser
solana-new clone <repo-id>         # clone a repo

# Agent mode — machine-readable output for Claude Code / Codex
solana-new search --agent          # all 178+ items
solana-new repos defi --agent      # filtered repos
solana-new skills --agent          # all skills
solana-new mcps --agent            # all MCPs
```

## Architecture

```
prompt → detectIntent → IntentSpec (IR)
                           ↓
                    recommendHarness → HarnessId or clone_repo
                           ↓            + suggested_skills + suggested_mcps
                    generatePlan → BuildPlan
                           ↓
                    scaffold → harness template or repo clone
                           ↓
                    run → execute build commands (dry-run default)
                           ↓
                    validate → 8 post-generation checks
                           ↓
                    repair → query Qdrant/local for known fixes
```

When no built-in harness matches, the router picks from the 59-repo catalog instead. The router always suggests relevant skills and MCPs alongside the harness/repo selection.

## Module Map

| Module | Path | Purpose |
|--------|------|---------|
| CLI | `cli/` | Command dispatcher, state, banner, interactive TUIs |
| Planner | `core/planner/` | Prompt → IntentSpec via agent adapter |
| Router | `core/router/` | IntentSpec → harness or repo + ecosystem suggestions |
| Repo Recommender | `core/router/recommend-repo.ts` | Search/recommend from 59-repo catalog |
| Ecosystem Suggester | `core/router/suggest-ecosystem.ts` | Match intent → relevant skills + MCPs |
| Scaffold | `core/scaffold/` | Copy harness templates or clone repos |
| Executor | `core/executor/` | Shell command runner (dry-run/execute) |
| Validator | `core/validator/` | Post-gen checks + system doctor |
| Repair | `core/repair/` | Qdrant-backed error→fix memory (local fallback) |
| Telemetry | `core/telemetry/` | Run tracking (Convex or ndjson fallback) |
| Knowledge | `core/knowledge/` | Trusted Solana skills context builder |
| Agents | `core/agents/` | Pluggable adapters: Codex CLI, Claude CLI |
| MCP | `mcp/` | MCP tool handler class |
| Types | `shared/types/` | All TypeScript types + JSON schemas |
| Constants | `shared/constants/` | harnesses.json, solana-skills.json, clonable-repos.json, solana-mcps.json |
| Harnesses | `harnesses/` | 5 starter templates |
| Qdrant | `qdrant/` | Repair memory schema + local fallback data |

## What's Indexed

| Catalog | Count | File |
|---------|-------|------|
| Repos | 59 | `shared/constants/clonable-repos.json` |
| Skills | 66 (14 official + 52 community) | `shared/constants/solana-skills.json` |
| MCPs | 49 | `shared/constants/solana-mcps.json` |
| Harnesses | 5 | `shared/constants/harnesses.json` |

## Harnesses

| ID | Surface | Description |
|----|---------|-------------|
| `next-anchor` | web | Next.js + wallet adapter + Anchor counter program |
| `payments` | payments/web | Solana Pay checkout with QR flow + verification API |
| `agent-wallet` | agent | AI wallet ops with policy-gated simulation + airdrop |
| `tg-bot` | telegram | Telegram bot with balance, transfer, airdrop commands |
| `mobile` | mobile | React Native + Expo + Solana Mobile Adapter + balance display |

## Key Types (shared/types/contracts.ts)

- `IntentSpec` — normalized IR: intent, surface, framework, wallet, network, features
- `BuildPlan` — plan with steps, commands, optional `clone_repo`, `suggested_skills`, `suggested_mcps`
- `RepoSource` — id, repo, clone_command, description (for repo-based scaffolding)
- `HarnessDefinition` — harness metadata (surface, framework, needs_program)
- `ValidationCheck` / `ValidationResult` — post-gen check results
- `RepairCase` / `RepairResult` — error→fix mappings with confidence scores
- `TelemetryRun` / `TelemetryStep` — observability records
- `ProjectState` — persisted state in .solana-new/state.json

## Environment Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `SOLANA_NEW_AGENT_PROVIDER` | Default agent | — |
| `SOLANA_NEW_CODEX_BIN` | Codex CLI path | `codex` |
| `SOLANA_NEW_CODEX_MODEL` | Codex model | `gpt-5.3-codex` |
| `SOLANA_NEW_CLAUDE_BIN` | Claude CLI path | `claude` |
| `SOLANA_NEW_CLAUDE_MODEL` | Claude model | `claude-3-7-sonnet-latest` |
| `CONVEX_URL` | Convex backend for telemetry | — (ndjson fallback) |
| `QDRANT_URL` | Qdrant server for repair memory | — (local JSON fallback) |
| `QDRANT_API_KEY` | Qdrant auth | — |
| `QDRANT_COLLECTION` | Qdrant collection name | `error_cases` |
| `SOLANA_NEW_NO_BANNER` | Disable ASCII banner | — |

## Conventions

- **ESM-only**: All imports use `.js` extensions (NodeNext module resolution)
- **Strict TypeScript**: strict mode, no implicit any
- **Devnet-only**: V1 enforces devnet for all execution
- **Deterministic over generative**: Prefer harness rules/templates over LLM-generated code
- **Ecosystem-aware**: Router suggests skills + MCPs alongside harness/repo selection
- **Agent responses are schema-constrained**: Always validated via JSON schema
- **Dry-run by default**: `run` requires explicit `--execute`

## Testing

```bash
pnpm test  # runs tests/planner.test.ts + tests/router.test.ts
```

Tests use mock agent adapters. See `docs/testing-guide.md` for the full local testing guide.

## Known Gaps

- Repair auto-apply disabled (returns fix steps only)
- Qdrant uses payload filtering, no vector embeddings yet
- MCP server has tool handlers but no transport server
- Harness templates are starters, not production-ready
- Dashboard UI not yet implemented
