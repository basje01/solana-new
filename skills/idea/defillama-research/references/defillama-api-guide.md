# DefiLlama API Guide

Free, no-auth API for DeFi data. Base URL: `https://api.llama.fi`

Full OpenAPI spec: `../../../data/defi/defillama-api.json`

## Key Endpoints

### TVL Data

| Endpoint | What It Returns |
|----------|----------------|
| `GET /protocols` | All protocols with TVL, category, chain, change metrics |
| `GET /protocol/{name}` | Detailed TVL history for one protocol |
| `GET /tvl/{name}` | Current TVL number for one protocol |
| `GET /v2/chains` | TVL per chain (Solana, Ethereum, etc.) |
| `GET /v2/historicalChainTvl/{chain}` | Historical TVL for a chain |

### Volume & Fees

| Endpoint | What It Returns |
|----------|----------------|
| `GET /overview/dexs` | DEX volume overview (all chains) |
| `GET /overview/dexs/{chain}` | DEX volume for one chain |
| `GET /overview/fees` | Fee/revenue overview |
| `GET /overview/fees/{chain}` | Fee/revenue for one chain |
| `GET /summary/fees/{protocol}` | Fee/revenue for one protocol |

### Yields

| Endpoint | What It Returns |
|----------|----------------|
| `GET /pools` | All yield pools with APY, TVL, chain |
| `GET /chart/{pool}` | Historical yield for one pool |

### Stablecoins

| Endpoint | What It Returns |
|----------|----------------|
| `GET /stablecoins` | All stablecoins with market cap, chain breakdown |
| `GET /stablecoincharts/{chain}` | Stablecoin flows for a chain |
| `GET /stablecoins/stablecoindominance/{chain}` | Stablecoin market share per chain |

### Market Intelligence

| Endpoint | What It Returns |
|----------|----------------|
| `GET /api/categories` | Protocol categories with aggregate TVL |
| `GET /api/raises` | Funding rounds for crypto projects |
| `GET /api/hacks` | Historical hacks and exploits |
| `GET /api/treasuries` | Protocol treasury holdings |
| `GET /api/forks` | Fork relationships between protocols |

## Filtering for Solana

The `/protocols` endpoint returns a `chain` field. Filter with:
- `chain === "Solana"` for Solana-only protocols
- `chains` array includes `"Solana"` for multi-chain protocols with Solana presence

The chain-specific endpoints (`/overview/dexs/Solana`, `/overview/fees/Solana`) return Solana-only data directly.

## SDKs

```bash
# JavaScript
npm install @defillama/api

# Python
pip install defillama-sdk
```

```typescript
import { DefiLlama } from '@defillama/api'
const client = new DefiLlama()
const protocols = await client.tvl.getProtocols()
const solanaProtocols = protocols.filter(p => p.chain === 'Solana' || p.chains?.includes('Solana'))
```

## Rate Limits

- Free tier: reasonable rate limits (undocumented exact numbers)
- No API key required
- Premium: $300/mo for higher limits
- For research queries, the free tier is more than enough
