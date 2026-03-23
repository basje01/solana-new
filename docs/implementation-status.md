# Implementation Status

## Completed

### Core Pipeline
1. Repository structure per PRD spec
2. Shared schemas: Intent IR, Telemetry run, Repair memory case
3. Node.js + TypeScript runtime with pnpm (ESM, strict mode)
4. CLI commands: `init`, `plan`, `scaffold`, `run`, `validate`, `doctor`, `repair`
5. Agent adapter system: Codex + Claude CLI with JSON-schema constrained outputs
6. Planner: prompt → IntentSpec via agent adapter
7. Router: IntentSpec → harness selection with trusted skills context
8. Scaffold engine: harness template copy or repo clone
9. Executor: shell command runner with dry-run/execute modes
10. Validator: 8 PRD-aligned post-generation checks
11. Repair: Qdrant retrieval with local JSON fallback (9 seeded cases)
12. Telemetry: run builder + Convex/ndjson storage adapter
13. MCP tool handler class (detect_intent, recommend_harness, scaffold, validate, repair, list_repos, search_repos)

### Ecosystem Catalogs
14. **59 clonable repos** indexed in `clonable-repos.json` — Solana official, Metaplex, Orca, Raydium, Jupiter, SendAI (29 repos including all SAK examples), community scaffolds
15. **66 skills** indexed in `solana-skills.json` — 14 official from solana.com + 52 community from sendaifun/skills and others
16. **49 MCP servers** indexed in `solana-mcps.json` — infrastructure, DeFi, wallet, security, data, tooling, trading, DAO, multi-chain
17. **5 built-in harnesses** with enhanced templates:
    - `next-anchor`: Counter program (init/increment/decrement), updated IDL, counter UI, tsconfig, next.config
    - `payments`: Payment verification API, layout, tsconfig, next.config
    - `agent-wallet`: CLI entry point (main.ts), airdrop utility, tsconfig
    - `tg-bot`: Real transfer execution, airdrop command, tsconfig
    - `mobile`: Balance display, airdrop button, Expo config, babel config, tsconfig

### Smart Routing
18. Router falls back to repo catalog when no harness matches
19. Ecosystem suggester: scores intent against skills + MCPs, includes suggestions in BuildPlan
20. `BuildPlan` supports `clone_repo`, `suggested_skills`, `suggested_mcps`

### Discover CLI
21. `search` — universal interactive TUI across all repos, skills, MCPs, harnesses (178+ items)
22. `repos` — interactive repo browser with fuzzy search
23. `skills` — interactive skill browser with fuzzy search
24. `mcps` — interactive MCP server browser with fuzzy search
25. Unknown commands fall through to universal search (`solana-new jupiter` → search)
26. `--agent` flag on all discover commands for machine-readable output
27. `clone` command for direct repo cloning

### Interactive TUI Features
28. Rounded input box with `>` prompt and placeholder text
29. Purple→pink gradient on "Search" label and "solana-new" in help
30. `(org/repo)` source display in yellow
31. `d` key toggles descriptions for all items
32. Cmd+Backspace / Ctrl+U clears search line
33. 15 items max visible with scroll indicators
34. Alternate screen buffer, cursor positioned in input box
35. Featured items on initial screen (3 harnesses + 4 repos + 4 skills + 4 MCPs)

### CLI Polish
36. Help screen split into Experimental (build pipeline) + Discover (ecosystem)
37. Aligned columns using ANSI-aware padding
38. Unit tests pass (planner + router with mock adapters)
39. Error normalization handles paths, versions, hex addresses

## Current Gaps

1. Repair auto-apply intentionally disabled (returns fix steps only)
2. Qdrant retrieval uses payload filtering (no vector embeddings yet)
3. MCP server defines tool handlers but no transport server process
4. Harness scaffolds are starter templates, not production-ready
5. Dashboard UI not yet implemented
6. Scaffold clone doesn't handle multi-step clone commands (e.g., `git clone && cd ...`)
7. No end-to-end integration tests for the full plan→scaffold→run pipeline with real agents
