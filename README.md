# solana.new

Deterministic AI-native build system for Solana. Converts natural language prompts into validated Solana dApps through structured harnesses, a 59-repo catalog, 66 skills, and 49 MCP servers — never letting the model guess what can be encoded as a rule or template.

## Quick Start

```bash
pnpm install && pnpm build
```

```bash
# Search the entire Solana ecosystem
npx solana-new search

# Or just type what you're looking for
npx solana-new defi
npx solana-new nft
npx solana-new jupiter
```

## How It Works

```
prompt → detect intent → match harness or clone repo → scaffold → build → validate → repair
                              ↕                            ↕
                     59 repos / 66 skills            suggest skills + MCPs
                     49 MCP servers
```

1. **`plan`** parses your prompt into a structured intent, picks the best harness (5 built-in templates) or clones from the repo catalog (59 repos), and suggests relevant skills + MCPs
2. **`scaffold`** generates the project — either from a harness template or by cloning a repo
3. **`run`** executes build commands (dry-run by default)
4. **`validate`** runs 8 Solana-specific checks (CLI, Anchor, wallet adapter, devnet, etc.)
5. **`repair`** queries a global error→fix memory when things fail

## Commands

### Build Pipeline (Experimental)

```bash
solana-new init                                    # Initialize project state
solana-new plan "Build a staking app" --agent codex  # Detect intent, pick harness, generate plan
solana-new scaffold --out ./my-app                 # Generate starter files
solana-new run --execute                           # Run build commands
solana-new validate                                # Post-generation checks
solana-new doctor                                  # Check system prerequisites
solana-new repair --stage validate --error "..."   # Query repair memory
```

### Discover (Explore the Solana Ecosystem)

```bash
solana-new search              # Universal interactive search (TUI)
solana-new jupiter             # Shorthand — any unknown command becomes search
solana-new repos               # Interactive repo browser
solana-new repos defi          # Static repo search
solana-new clone jupiter-nextjs-example --out ./swap-app
solana-new skills              # Interactive skill browser
solana-new skills anchor       # Static skill search
solana-new mcps                # Interactive MCP server browser
solana-new mcps helius         # Static MCP search
```

Add `--agent` to any discover command for machine-readable output (for Claude Code / Codex):

```bash
solana-new search --agent          # All 178+ items as plaintext
solana-new repos defi --agent      # Filtered repos
solana-new skills --agent          # All skills
solana-new mcps --agent            # All MCP servers
```

## What's Indexed

| Catalog | Count | Source |
|---------|-------|--------|
| **Repos** | 59 | Solana official, Metaplex, Orca, Raydium, Jupiter, SendAI examples, community scaffolds |
| **Skills** | 66 | solana.com/skills (14 official + 52 community from sendaifun/skills and others) |
| **MCPs** | 49 | Helius, Jupiter, Phantom, Orca, Chainstack, openSVM, security scanners, DAO tools |
| **Harnesses** | 5 | Built-in templates: next-anchor, payments, agent-wallet, tg-bot, mobile |

## Built-in Harnesses

| ID | Surface | What you get |
|----|---------|-------------|
| `next-anchor` | web | Next.js + wallet adapter + Anchor counter program |
| `payments` | payments | Solana Pay checkout with QR flow + verification API |
| `agent-wallet` | agent | AI wallet ops with policy-gated simulation + airdrop |
| `tg-bot` | telegram | Telegram bot with balance, transfer, airdrop commands |
| `mobile` | mobile | React Native + Expo + Solana Mobile Adapter + balance display |

## Architecture

```
cli/                    Command dispatcher, state, banner
core/
  planner/              Prompt → IntentSpec via agent adapter
  router/               IntentSpec → harness or repo, ecosystem suggestions
  scaffold/             Copy harness templates or clone repos
  executor/             Shell command runner (dry-run/execute)
  validator/            Post-gen checks + system doctor
  repair/               Qdrant-backed error→fix memory (local fallback)
  telemetry/            Run tracking (Convex or ndjson)
  knowledge/            Trusted Solana skills context
  agents/               Pluggable adapters: Codex CLI, Claude CLI
mcp/                    MCP tool handler class
shared/
  types/                TypeScript types + JSON schemas
  constants/            harnesses.json, solana-skills.json, clonable-repos.json, solana-mcps.json
  utils/                File system utilities
harnesses/              5 starter templates
qdrant/                 Repair memory schema + local fallback data
```

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `SOLANA_NEW_AGENT_PROVIDER` | Default agent (`codex` or `claude`) |
| `SOLANA_NEW_CODEX_BIN` | Codex CLI path (default: `codex`) |
| `SOLANA_NEW_CODEX_MODEL` | Codex model (default: `gpt-5.3-codex`) |
| `SOLANA_NEW_CLAUDE_BIN` | Claude CLI path (default: `claude`) |
| `SOLANA_NEW_CLAUDE_MODEL` | Claude model (default: `claude-3-7-sonnet-latest`) |
| `CONVEX_URL` | Convex backend for telemetry |
| `QDRANT_URL` | Qdrant server for repair memory |
| `QDRANT_API_KEY` | Qdrant auth |
| `SOLANA_NEW_NO_BANNER` | Disable ASCII banner |

## Key Design Decisions

- **Deterministic over generative** — prefer harness rules/templates over LLM-generated code
- **Devnet-only** — V1 enforces devnet for all execution
- **Agent responses are schema-constrained** — always validated via JSON schema
- **Dry-run by default** — `run` requires explicit `--execute`
- **ESM-only** — all imports use `.js` extensions (NodeNext)
- **Ecosystem-aware** — router suggests skills and MCPs alongside harnesses

## Implementation Status

See [docs/implementation-status.md](docs/implementation-status.md) for current gaps and roadmap.

## Testing

See [docs/testing-guide.md](docs/testing-guide.md) for the full local testing guide.
