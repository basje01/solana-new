# Solana Dev Patterns

Common patterns for new Solana developers building with Claude Code.

## Connection & Wallet

```typescript
// Always use @solana/web3.js v2 patterns where possible
import { Connection, clusterApiUrl } from "@solana/web3.js";

const connection = new Connection(
  process.env.HELIUS_RPC_URL || clusterApiUrl("devnet")
);
```

- Use Helius RPC for production (rate limits, reliability)
- Always default to devnet during development
- Store RPC URLs in .env, never hardcode

## Transaction Patterns

- **Versioned transactions**: Always use v0 transactions for new code
- **Priority fees**: Add compute budget instructions for mainnet
- **Retry logic**: Transactions can fail silently — confirm with `confirmTransaction`
- **Simulation**: Always simulate before sending on mainnet

## Program Interaction

- Use Anchor's IDL-based client generation for typed interactions
- For raw programs, use `TransactionInstruction` with proper account metas
- Always handle `AccountNotFound` — it's the most common error

## Token Operations

- SPL Token for fungible tokens
- Metaplex for NFTs (use compressed NFTs at scale)
- Always check token decimals before displaying amounts

## Common Gotchas

1. **Rent**: New accounts need minimum rent-exempt balance
2. **Account size**: Must be declared at creation, can't resize easily
3. **PDA derivation**: Seeds must match exactly between client and program
4. **Compute limits**: Default is 200k CU — request more if needed
5. **Blockhash expiry**: Recent blockhash expires after ~60 seconds
