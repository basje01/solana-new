# Architecture Patterns

Common Solana application architectures.

## Pattern 1: Next.js + Anchor dApp

```
my-dapp/
  app/                    # Next.js App Router
    layout.tsx            # Wallet provider, theme
    page.tsx              # Landing / main UI
    api/                  # API routes (optional)
  programs/
    my-program/           # Anchor program
      src/lib.rs
      Cargo.toml
  tests/                  # Anchor tests
  CLAUDE.md               # Project context for Claude Code
  .claude/settings.json   # MCP configuration
```

Best for: DeFi apps, NFT platforms, any user-facing dApp.

## Pattern 2: Solana Agent Kit

```
my-agent/
  src/
    index.ts              # Agent entry point
    tools/                # Custom agent tools
    config.ts             # Wallet, RPC, API keys
  CLAUDE.md
  .claude/settings.json
```

Best for: Trading bots, autonomous agents, AI-powered tools.

## Pattern 3: Telegram/Discord Bot

```
my-bot/
  src/
    bot.ts                # Bot framework setup
    commands/             # Slash commands
    handlers/             # Message handlers
    solana/               # Solana interaction layer
  CLAUDE.md
  .claude/settings.json
```

Best for: Community tools, notification bots, trading bots with social interface.

## Pattern 4: On-chain Program

```
my-program/
  programs/
    my-program/
      src/
        lib.rs            # Program entry
        state.rs          # Account structures
        instructions/     # Instruction handlers
        error.rs          # Custom errors
  tests/
  migrations/
  CLAUDE.md
```

Best for: Protocol development, custom on-chain logic, DeFi primitives.

## Pattern 5: Data Pipeline

```
my-pipeline/
  src/
    indexer.ts            # Transaction/account indexing
    processors/           # Data transformation
    api/                  # Query API
    storage/              # Database layer
  CLAUDE.md
  .claude/settings.json
```

Best for: Analytics, monitoring, research tools.
