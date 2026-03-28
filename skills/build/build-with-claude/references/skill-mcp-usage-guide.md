# Skill & MCP Usage Guide

How to effectively use installed Claude Code skills and MCP servers during development.

## Skills

Skills are Claude Code SKILL.md files that give Claude domain expertise. When a skill is installed:
- Claude automatically reads the SKILL.md when relevant prompts are detected
- Skills contain references, frameworks, and best practices for a specific domain
- You don't need to "call" them — just ask Claude about the domain

### Effective Usage
- "How do I swap tokens using Jupiter?" → triggers Jupiter Skill
- "Write an Anchor program for staking" → triggers Programs (Anchor) Skill
- "Review this code for security issues" → triggers Security Skill

### Tips
- Check which skills are installed: look at the `skills` section in your project's CLAUDE.md
- If Claude seems to lack domain knowledge, verify the relevant skill is installed
- Skills stack — having both "Jupiter" and "DeFi" skills gives Claude richer context

## MCP Servers

MCPs give Claude access to external APIs and data. When an MCP is configured:
- Claude can call MCP tools to fetch real-time data
- MCPs appear in `.claude/settings.json` under `mcpServers`

### Common MCPs and Their Tools
- **Helius MCP**: Fetch account data, transaction history, token balances, DAS API
- **Jupiter MCP**: Get swap quotes, route information, token prices
- **Solana Developer MCP**: Search Solana documentation, get program examples
- **DexScreener MCP**: Token prices, pair data, trending tokens

### Tips
- Use MCPs for real-time data instead of hardcoding values
- If an MCP call fails, check your API key in `.env`
- MCPs are especially useful for testing — verify on-chain state after transactions
