# Comprehensive Catalog of Solana MCP Servers

> Research reference — the curated subset is indexed in `shared/constants/solana-mcps.json` (49 servers).
> Last updated: 2026-03-23
> Total servers researched: 50+

---

## Table of Contents

1. [Official / Foundation MCP Servers](#1-official--foundation-mcp-servers)
2. [SendAI (sendaifun) MCP Servers](#2-sendai-sendaifun-mcp-servers)
3. [Infrastructure / RPC MCP Servers](#3-infrastructure--rpc-mcp-servers)
4. [DeFi Protocol MCP Servers](#4-defi-protocol-mcp-servers)
5. [Wallet MCP Servers](#5-wallet-mcp-servers)
6. [Token Launch / Memecoin MCP Servers](#6-token-launch--memecoin-mcp-servers)
7. [Trading / Sniping MCP Servers](#7-trading--sniping-mcp-servers)
8. [Security / Rug Check MCP Servers](#8-security--rug-check-mcp-servers)
9. [Data / Analytics MCP Servers](#9-data--analytics-mcp-servers)
10. [Developer Tooling MCP Servers](#10-developer-tooling-mcp-servers)
11. [DAO / Governance MCP Servers](#11-dao--governance-mcp-servers)
12. [Multi-Chain MCP Servers with Solana Support](#12-multi-chain-mcp-servers-with-solana-support)
13. [Niche / Specialty MCP Servers](#13-niche--specialty-mcp-servers)
14. [Registries / Discovery](#14-registries--discovery)

---

## 1. Official / Foundation MCP Servers

### solana-mcp-official
- **ID**: `solana-mcp-official`
- **GitHub**: https://github.com/solana-foundation/solana-mcp-official
- **Live Endpoint**: https://mcp.solana.com/mcp
- **Description**: The official Solana Developer MCP. Serves up-to-date documentation across the Solana ecosystem to developers and AI agents. Powers both a landing page and MCP API endpoints.
- **Category**: documentation, infrastructure
- **Setup**:
  ```bash
  claude mcp add --transport http solana-mcp-server https://mcp.solana.com/mcp
  ```
- **Tools/Resources**: Real-time Solana documentation search, account queries, transaction analysis, CPI statement generation, Anchor Framework expert

### solana-dev-mcp
- **ID**: `solana-dev-mcp`
- **GitHub**: https://github.com/solana-foundation/solana-dev-mcp
- **Description**: Solana Foundation's demo MCP server implementation showcasing basic Solana RPC methods.
- **Category**: infrastructure, demo
- **Setup**: Clone and build locally
- **Tools**: `getBalance`, `getAccountInfo`, `getTransaction`

---

## 2. SendAI (sendaifun) MCP Servers

### solana-mcp (Solana Agent Kit MCP)
- **ID**: `solana-mcp`
- **GitHub**: https://github.com/sendaifun/solana-mcp
- **npm**: `solana-mcp`
- **Description**: MCP server powered by the Solana Agent Kit. Provides comprehensive onchain tools for AI agents to interact with Solana blockchain through a standardized interface.
- **Category**: infrastructure, defi, tooling
- **Setup**:
  ```bash
  npm install -g solana-mcp
  ```
  Or use the install script:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/sendaifun/solana-mcp/main/scripts/install.sh -o solana-mcp-install.sh && chmod +x solana-mcp-install.sh && ./solana-mcp-install.sh --backup
  ```
- **Tools**: `GET_ASSET`, `DEPLOY_TOKEN`, `GET_PRICE`, `WALLET_ADDRESS`, `BALANCE`, `TRANSFER`, `MINT_NFT`, `TRADE`, `REQUEST_FUNDS`, `RESOLVE_DOMAIN`, `GET_TPS`

### @solana-agent-kit/adapter-mcp
- **ID**: `solana-agent-kit-adapter-mcp`
- **GitHub**: https://github.com/sendaifun/solana-agent-kit/tree/v2/packages/adapter-mcp
- **npm**: `@solana-agent-kit/adapter-mcp`
- **Description**: Official MCP adapter for the Solana Agent Kit. Framework for creating MCP servers that handle all protocol operations on Solana with support for 60+ actions.
- **Category**: framework, tooling
- **Setup**:
  ```bash
  npm install @solana-agent-kit/adapter-mcp
  ```
- **Tools**: All Solana Agent Kit actions including token trading, lending, staking, NFT operations, Drift perps, cross-chain operations

---

## 3. Infrastructure / RPC MCP Servers

### helius-mcp (Official Helius)
- **ID**: `helius-mcp`
- **GitHub**: https://github.com/helius-labs/core-ai
- **npm**: `helius-mcp`
- **Description**: Official Helius AI tooling. 60+ tools across 10 domain categories giving AI tools direct access to Helius APIs for querying Solana, sending transactions, managing webhooks, streaming data, wallet analysis.
- **Category**: infrastructure, data
- **Setup**:
  ```bash
  claude mcp add helius npx helius-mcp@latest
  ```
- **Tools** (10 domain routers):
  - `heliusAccount` — account setup, auth, plans, billing
  - `heliusWallet` — wallet balances, holdings, identity, history
  - `heliusAsset` — assets, NFTs, collections, token holders
  - `heliusTransaction` — parsed transactions, wallet tx history
  - `heliusChain` — raw chain state, token accounts, blocks, network status, stake reads, priority fees
  - `heliusStreaming` — webhook CRUD, live subscription config
  - `heliusKnowledge` — docs, guides, pricing, troubleshooting, SIMDs
  - `heliusWrite` — SOL/token transfers, staking mutations
  - `heliusCompression` — compressed account, proof, balance, history queries
  - `expandResult` — expand summary-first results by resultId

### mcp-server-helius (dcSpark)
- **ID**: `dcspark-helius`
- **GitHub**: https://github.com/dcSpark/mcp-server-helius
- **Description**: Community Helius MCP server providing Claude access to Solana blockchain data via Helius API.
- **Category**: infrastructure, data
- **Setup**: Clone, `npm ci`, `npm run build`

### solana-helius-mcp (embetter)
- **ID**: `embetter-solana-helius-mcp`
- **GitHub**: https://github.com/embetter/solana-helius-mcp
- **Description**: Solana blockchain tools powered by Helius APIs for use with Cursor and other MCP-compatible clients.
- **Category**: infrastructure, data

### openSVM solana-mcp-server
- **ID**: `opensvm-solana-mcp-server`
- **GitHub**: https://github.com/openSVM/solana-mcp-server
- **Docs**: https://opensvm.github.io/solana-mcp-server/
- **Description**: Comprehensive MCP server implementing 73+ Solana RPC methods. Supports stdio and web modes. Multi-SVM-network support.
- **Category**: infrastructure, rpc
- **Setup**: Clone and build; supports stdio (Claude Desktop) and web (HTTP API) modes
- **Tools**: 73+ RPC methods across accounts, blocks, transactions, tokens, system operations

### rpc-nodes-mcp (Chainstack)
- **ID**: `chainstack-rpc-nodes-mcp`
- **GitHub**: https://github.com/chainstacklabs/rpc-nodes-mcp
- **Description**: Minimal, fast, extensible MCP server for JSON-RPC blockchain nodes. Supports both EVM and Solana blockchains. Real-time Solana interactions, account queries, program calls, transaction analysis.
- **Category**: infrastructure, rpc
- **Setup**: Configure with Chainstack RPC endpoint in `claude_desktop_config.json`

### quicknode-mcp
- **ID**: `quicknode-mcp`
- **Docs**: https://www.quicknode.com/docs/build-with-ai/quicknode-mcp
- **Guide**: https://www.quicknode.com/guides/ai/solana-mcp-server
- **Sample**: https://github.com/quiknode-labs/qn-guide-examples/tree/main/AI/solana-mcp
- **Description**: MCP server wrapping QuickNode's Admin API. Lets AI agents provision and manage QuickNode blockchain infrastructure through natural language.
- **Category**: infrastructure
- **Setup**: Configure with QuickNode RPC endpoint

### aldrin-labs solana-mcp-server
- **ID**: `aldrin-labs-solana-mcp-server`
- **GitHub**: https://github.com/aldrin-labs/solana-mcp-server
- **Description**: Comprehensive MCP server providing 21 essential Solana RPC methods including account operations, token management, system information, and staking functionality.
- **Category**: infrastructure, rpc
- **Tools**: 21 RPC methods covering account/balance operations, block/transaction info, token operations, system info, staking/governance

### @expertvagabond/solana-mcp-server
- **ID**: `expertvagabond-solana-mcp-server`
- **npm**: `@expertvagabond/solana-mcp-server`
- **Description**: MCP server for Solana blockchain interactions — wallet management, transaction handling, program interactions.
- **Category**: infrastructure, wallet

---

## 4. DeFi Protocol MCP Servers

### mcp-server-jupiter (dcSpark)
- **ID**: `dcspark-jupiter`
- **GitHub**: https://github.com/dcSpark/mcp-server-jupiter
- **npx**: `@mcp-dockmaster/mcp-server-jupiter`
- **Description**: MCP server for Jupiter's swap API on Solana. Token swapping: quote retrieval, transaction building, and execution.
- **Category**: defi, dex
- **Setup**:
  ```bash
  npx @mcp-dockmaster/mcp-server-jupiter
  ```
- **Tools**: `jupiter_get_quote`, `jupiter_build_swap_transaction`, `jupiter_send_swap_transaction`

### jupiter-mcp (araa47)
- **ID**: `araa47-jupiter-mcp`
- **GitHub**: https://github.com/araa47/jupiter-mcp
- **Description**: Full-featured Jupiter MCP supporting Ultra API (immediate swaps) and Trigger API (limit orders). Token search, portfolio management, security info via Shield.
- **Category**: defi, dex, trading
- **Setup**: DXT one-click install, Cursor deeplink, or manual config. Requires `PRIVATE_KEY` env var.
- **Tools**:
  - **Ultra API**: `get_swap_quote`, `execute_swap_transaction`, `get_balances`, `get_shield`, `search_token`
  - **Trigger API**: `create_limit_order`, `execute_limit_order`, `cancel_limit_order`, `cancel_limit_orders`, `get_limit_orders`

### solana-limit-order-mcp
- **ID**: `solana-limit-order-mcp`
- **GitHub**: https://github.com/dimitrov-d/solana-limit-order-mcp
- **Description**: MCP server for placing limit orders on Solana via Jupiter. Set limit buy/sell orders, view open/historical orders, cancel orders, trade tokens, fetch balances/prices.
- **Category**: defi, trading

### demcp-orca-mcp
- **ID**: `demcp-orca-mcp`
- **GitHub**: https://github.com/demcp/demcp-orca-mcp
- **Description**: Comprehensive tools for interacting with Orca DEX on Solana and Eclipse networks. Token swaps, liquidity operations, pool analytics via MCP.
- **Category**: defi, dex
- **Setup**: Configure via env vars (network: solanaMainnet, solanaDevnet, eclipseMainnet, eclipseTestnet)

### marinade-finance-mcp-server
- **ID**: `marinade-finance-mcp-server`
- **GitHub**: https://github.com/leandrogavidia/marinade-finance-mcp-server
- **Description**: MCP server for Marinade Finance on Solana. Liquid staking operations (stake/unstake), mSOL balance checks, mSOL transfers, protocol state queries, documentation search.
- **Category**: defi, staking
- **Setup**: Supports stdio and streamable-http transport modes

### metaplex-genesis-mcp
- **ID**: `metaplex-genesis-mcp`
- **GitHub**: https://github.com/maikershq/metaplex-genesis-mcp
- **Description**: MCP server for interacting with the Metaplex Genesis program on Solana. Fetch accounts, query bonding curves, get swap quotes.
- **Category**: defi, token-launch
- **Setup**: Requires `SOLANA_RPC_URL` env var

### solentic (Blueprint Agentic Staking)
- **ID**: `solentic`
- **GitHub**: https://github.com/blueprint-infrastructure/solentic
- **Endpoint**: https://solentic.theblueprint.xyz/mcp
- **Description**: Native Solana staking infrastructure for AI agents. 18 MCP tools, 21 REST endpoints, 13 A2A skills.
- **Category**: defi, staking
- **Setup**: Connect to remote MCP endpoint

### dflow-mcp (Prediction Markets)
- **ID**: `dflow-mcp`
- **GitHub**: https://github.com/openSVM/dflow-mcp (23 tools), https://github.com/ba1nch0d/dflow-mcp, https://github.com/joinQuantish/kalshi-mcp
- **npm**: `@quantish/kalshi-server`
- **Description**: Unified spot + prediction market trading API on Solana via DFlow. Trade on Kalshi markets with smart routing, events, forecasts, candlesticks, live data.
- **Category**: defi, prediction-markets
- **Tools**: 23 tools for events, markets, trades, forecasts, candlesticks, live data

---

## 5. Wallet MCP Servers

### @phantom/mcp-server
- **ID**: `phantom-mcp-server`
- **npm**: `@phantom/mcp-server`
- **Docs**: https://docs.phantom.com/resources/mcp-server
- **Description**: Official Phantom MCP server for wallet operations. Embedded wallet access, view addresses, sign/send transactions, sign messages across Solana and EVM chains. Includes AI signing safeguards.
- **Category**: wallet
- **Setup**:
  ```bash
  npm i @phantom/mcp-server
  ```
- **Tools**: Connection status, wallet address retrieval, transaction signing, token swaps, transfers (multi-chain: Solana + EVM)

### Phantom Connect SDK MCP
- **ID**: `phantom-connect-sdk-mcp`
- **Docs**: https://docs.phantom.com/resources/mcp-server
- **Description**: Connects AI coding assistants (Cursor, Claude, VS Code) to Phantom developer documentation.
- **Category**: wallet, documentation

### privy-mcp-server
- **ID**: `privy-mcp-server`
- **GitHub**: https://github.com/incentivai-io/privy-mcp-server
- **Description**: MCP server for Privy.io. User management, wallet operations, blockchain interactions. Supports Ethereum, Solana, Bitcoin, and all EVM chains.
- **Category**: wallet, infrastructure
- **Tools**: Get user by DID, search users, wallet creation/pregeneration, wallet transactions, user management

### WalletMCP
- **ID**: `wallet-mcp`
- **GitHub**: https://github.com/paulfruitful/WalletMCP
- **Description**: Simple MCP server for interacting with Solana wallets. Retrieve transactions, SOL balances, program logs, close BPF buffers, send SOL.
- **Category**: wallet
- **Tools**: Get wallet transactions, get SOL balance, access program logs, claim unused rents, send SOL

### grandbusta-solana-mcp
- **ID**: `grandbusta-solana-mcp`
- **GitHub**: https://github.com/Grandbusta/solana-mcp
- **Description**: MCP server to interact with Solana using your own private key. Basic wallet operations.
- **Category**: wallet
- **Setup**:
  ```bash
  npx -y @smithery/cli install @Grandbusta/solana-mcp --client claude
  ```
- **Tools**: Get latest slot, get wallet address, get wallet balance, transfer SOL

---

## 6. Token Launch / Memecoin MCP Servers

### PUMP-MCP (8bitsats)
- **ID**: `pump-mcp`
- **GitHub**: https://github.com/8bitsats/PUMP-MCP
- **Description**: MCP server for creating and managing Solana tokens on Pump.fun via Claude Desktop. Create tokens, buy/sell, token info, account management.
- **Category**: token-launch, memecoin
- **Tools**: Create tokens, buy tokens, sell tokens, get token info, manage accounts, check balances

### pumpfun-mcp-server (noahgsolomon)
- **ID**: `pumpfun-mcp-server`
- **GitHub**: https://github.com/noahgsolomon/pumpfun-mcp-server
- **Description**: MCP server for Pump.fun platform. Create, buy, sell tokens. Automatic keypair management.
- **Category**: token-launch, memecoin
- **Setup**: Requires Helius RPC URL in env vars

### PUMPFUN-MCP (eskayML)
- **ID**: `eskayml-pumpfun-mcp`
- **GitHub**: https://github.com/eskayML/PUMPFUN-MCP
- **Description**: MCP server for interacting with Pump.fun. Create, buy, sell tokens on the platform.
- **Category**: token-launch, memecoin

### pumpfun-dune-mcp
- **ID**: `pumpfun-dune-mcp`
- **GitHub**: https://github.com/yance-zhang/pumpfun-dune-mcp
- **Description**: Pump.fun MCP server with Dune Analytics integration for data queries.
- **Category**: token-launch, data

### mcp-meme-deployer
- **ID**: `mcp-meme-deployer`
- **GitHub**: https://github.com/kirabuilds/mcp-meme-deployer
- **Description**: Deploy instantly tradable tokens on Solana at zero cost through Claude Desktop conversation.
- **Category**: token-launch, memecoin

### memecoin-observatory-mcp
- **ID**: `memecoin-observatory-mcp`
- **GitHub**: https://github.com/tony-42069/solana-mcp
- **Description**: Comprehensive Solana MCP server for analyzing memecoins. Real-time memecoin radar, social signal analysis, whale wallet tracking, cultural analysis, on-chain data.
- **Category**: memecoin, analytics

---

## 7. Trading / Sniping MCP Servers

### 100ms-SPL-Token-Sniper-MCP (Raydium Sniper)
- **ID**: `100ms-spl-token-sniper-mcp`
- **GitHub**: https://github.com/monostate/100ms-spl-token-sniper-mcp
- **Description**: High-speed token sniping MCP for Solana SPL tokens with Raydium pools. Multi-region execution (US, Asia, Europe), WebSocket pool monitoring, GraphQL discovery, 100ms target execution.
- **Category**: trading, sniping
- **Tools**: Snipe tokens, check wallet balance, configure trading params, demo mode

### quant72-mcp
- **ID**: `quant72-mcp`
- **GitHub**: https://github.com/Quant72AI/quant72-mcp
- **Description**: On-chain quantitative trading expert with multiple market data sources. Integrates all Solana Agent Kit operations for professional-grade trading.
- **Category**: trading, analytics

### Solana-MCP-Trading-Server (8bitsats)
- **ID**: `solana-mcp-trading-server`
- **GitHub**: https://github.com/8bitsats/Solana-MCP-Trading-Server
- **Description**: Shows trending tokens, integrates Grok/xAI image understanding, Claude computer use. AI-powered token generation, image creation, DNA sequence generation, token deployment.
- **Category**: trading, ai

### GROK_MCP (8bitsats)
- **ID**: `grok-mcp`
- **GitHub**: https://github.com/8bitsats/GROK_MCP
- **Description**: Grok AI MCP server for Solana blockchain analysis. Analyzes transactions, addresses, images using Grok's vision capabilities.
- **Category**: trading, analytics, ai

---

## 8. Security / Rug Check MCP Servers

### rug-check-mcp
- **ID**: `rug-check-mcp`
- **GitHub**: https://github.com/kukapay/rug-check-mcp
- **Description**: Detects potential risks in Solana meme tokens. Helps AI agents avoid rug pulls and unsafe projects.
- **Category**: security

### cryptoleek-solana-rugcheck
- **ID**: `cryptoleek-solana-rugcheck`
- **GitHub**: https://github.com/cryptoleek-team/awesome-solana-mcp
- **Description**: Solana RugCheck & Transaction Helper. RugCheck for scam detection + TransactionHelper for fetching/filtering transaction history.
- **Category**: security, data
- **Tools**: `RugCheck` (scam detection), `TransactionHelper` (tx history), plus core Solana tools (GET_ASSET, MINT_NFT, DEPLOY_TOKEN, TRANSFER, TRADE, GET_TPS, BALANCE, REQUEST_FUNDS, REGISTER_DOMAIN)

### token-rugcheck (AetherCore)
- **ID**: `aethercore-token-rugcheck`
- **GitHub**: https://github.com/AetherCore-Dev/token-rugcheck
- **Endpoint**: https://rugcheck.aethercore.dev
- **Description**: Three-layer safety audit for Solana tokens: machine verdict, LLM analysis, raw on-chain evidence. Cross-references RugCheck.xyz, DexScreener, GoPlus Security. Uses x402 micropayments ($0.02 USDC per check).
- **Category**: security

### solana-wallet-security-scanner
- **ID**: `solana-wallet-security-scanner`
- **GitHub**: https://github.com/mohitparmar1/Solana-Wallet-Security-Scanner
- **Description**: Scans Solana wallets for threats and detects suspicious programs.
- **Category**: security

### solana-fender-mcp (Anchor Security)
- **ID**: `solana-fender-mcp`
- **GitHub**: https://github.com/honey-guard/solana-fender
- **Description**: Security analysis for Solana Anchor programs. Static analysis tool that checks smart contracts against known vulnerability patterns directly within development environments.
- **Category**: security, tooling

---

## 9. Data / Analytics MCP Servers

### DexScreener MCP (openSVM)
- **ID**: `opensvm-dexscreener-mcp`
- **GitHub**: https://github.com/openSVM/dexscreener-mcp-server
- **Description**: Real-time DEX pair data, token information, market statistics across multiple blockchains (best on Solana).
- **Category**: data, dex
- **Setup**:
  ```bash
  claude mcp add-json "dexscreener" '{"command":"npx","args":["-y","@opensvm/dexscreener-mcp-server"]}'
  ```

### mcp-dexscreener (janswist)
- **ID**: `janswist-mcp-dexscreener`
- **GitHub**: https://github.com/janswist/mcp-dexscreener
- **Description**: DexScreener API MCP server. Check any on-chain price using DexScreener's free and open API.
- **Category**: data, dex

### dexscreener-cli-mcp-tool (vibeforge)
- **ID**: `vibeforge-dexscreener-cli-mcp`
- **GitHub**: https://github.com/vibeforge1111/dexscreener-cli-mcp-tool
- **Description**: Visual DexScreener terminal CLI + MCP scanner. 4 resources, 3 prompts. Talk to scanner in plain English.
- **Category**: data, dex, trading

### spice (Nimbus/Flipside)
- **ID**: `spice-mcp`
- **GitHub**: https://github.com/getnimbus/spice
- **Description**: Queries Solana blockchain data via Flipside API. Fetch catalog metadata and run Flipside queries.
- **Category**: data, analytics
- **Setup**: Requires Flipside API key

### hubble-ai-mcp
- **ID**: `hubble-ai-mcp`
- **GitHub**: https://github.com/HubbleVision/hubble-ai-mcp
- **Description**: Analyzes and visualizes transactions on PumpFun and DEXs via natural language. Generates bar, line, pie, doughnut, radar charts.
- **Category**: data, visualization
- **Setup**: `npx` based, requires API key env var

### solana-defi-analytics-mcp
- **ID**: `solana-defi-analytics-mcp`
- **GitHub**: https://github.com/kirtiraj22/solana-mcp
- **Description**: Wallet analytics, transaction monitoring, DeFi strategy optimization for Solana.
- **Category**: data, analytics, defi

### solana-mcp-server (AiAgentKarl)
- **ID**: `aiagentkarl-solana-mcp-server`
- **GitHub**: https://github.com/AiAgentKarl/solana-mcp-server
- **Description**: Access Solana blockchain data. Wallet balances, transaction history, token prices, DeFi yields from Raydium and Orca, token safety checks via RugCheck.
- **Category**: data, defi, security
- **Clients**: Helius, Jupiter, CoinGecko, Raydium, Orca, RugCheck

### solana-forum-summarizer-mcp
- **ID**: `solana-forum-summarizer-mcp`
- **GitHub**: https://github.com/dimitrov-d/solana-forum-summarizer-mcp
- **Description**: Browse and summarize the Solana Forum. Get latest/popular posts, group by category/author, search by keyword, summarize content.
- **Category**: data, community

### AMOCA MCP Server
- **ID**: `amoca-solana-mcp-server`
- **GitHub**: https://github.com/manolaz/amoca-solana-mcp-server
- **Description**: Specialized Solana wallet analysis. Detailed token balance analysis, portfolio valuation, historical transaction review.
- **Category**: data, wallet-analytics

---

## 10. Developer Tooling MCP Servers

### anchor-mcp
- **ID**: `anchor-mcp`
- **GitHub**: https://github.com/honey-guard/anchor-mcp
- **Description**: MCP CLI server template for Anchor programs. Expose security checks and Anchor-specific tools to LLMs.
- **Category**: tooling, security
- **Setup**: Install via Cargo as `anchor-mcp` crate. Run with `--mcp` flag.
- **Tools**: `security_check_program`, `security_check_file`

### solana-web3js-mcp-server
- **ID**: `solana-web3js-mcp-server`
- **GitHub**: https://github.com/FrankGenGo/solana-web3js-mcp-server
- **Description**: MCP server enabling AI assistants to develop and deploy Solana smart contracts end-to-end. Bridge between AI language models and Solana blockchain using web3.js.
- **Category**: tooling, development

### SolMCP
- **ID**: `solmcp`
- **GitHub**: https://github.com/N-45div/SolMCP---SendAI-MCP-competition
- **Description**: Python-based Solana MCP server with 7 tools. Integrates Helius, DexScreener, and Pyth oracle for price feeds. Designed for degens, validators, and node operators.
- **Category**: tooling, data

### omaidf-solana-mcp
- **ID**: `omaidf-solana-mcp`
- **GitHub**: https://github.com/omaidf/solana-mcp
- **Description**: Python-based MCP server implementing the Model Context Protocol for Solana blockchain operations.
- **Category**: tooling

### GOATsolana-mcp
- **ID**: `goatsolana-mcp`
- **GitHub**: https://github.com/FarseenSh/GOATsolana-mcp
- **Description**: Enables Claude to access, analyze, and visualize Solana blockchain data through natural language conversations.
- **Category**: tooling, data

### caiovicentino-Solana-MCP
- **ID**: `caiovicentino-solana-mcp`
- **GitHub**: https://github.com/caiovicentino/Solana-MCP
- **Description**: Powerful MCP server for AI agents to interact with Solana DeFi protocols. Query balances, transfer tokens, execute swaps, fetch prices, advanced DeFi ops. Built on Solana Agent Kit.
- **Category**: tooling, defi

---

## 11. DAO / Governance MCP Servers

### daoCLI
- **ID**: `daocli`
- **GitHub**: https://github.com/DaoCLI/daoCLI-init
- **Description**: MCP-compatible DAO server enabling AI agents to create and manage programmatic DAOs across Solana and StarkNet. CLI-first approach for token creation, AMM setup, governance, multisig.
- **Category**: dao, governance

### assetCLI
- **ID**: `assetcli`
- **GitHub**: https://github.com/assetCLI/assetCLI-init
- **Description**: Winner of the Solana MCP AI Agent Competition. "Goldman Sachs for AI Agents." Bonding curves, DEX integrations, DAO creation, treasury management, governance, multisig operations.
- **Category**: dao, defi, token-launch

---

## 12. Multi-Chain MCP Servers with Solana Support

### GOAT SDK MCP
- **ID**: `goat-sdk-mcp`
- **GitHub**: https://github.com/goat-sdk/goat
- **Description**: The largest agentic finance toolkit for AI agents. 200+ integrations. MCP server supporting EVM and Solana chains. Money transmission, investing, asset purchases.
- **Category**: multi-chain, defi, framework
- **Setup**: Clone GOAT repo, build packages, configure MCP server with Solana settings

### Hummingbot MCP
- **ID**: `hummingbot-mcp`
- **GitHub**: https://github.com/hummingbot/mcp
- **Docker**: `hummingbot/mcp`
- **Description**: MCP server enabling Claude/Gemini CLI to control Hummingbot for automated crypto trading. Portfolio balances, order management, multi-step trading operations. Includes Orca (Solana DEX) connector.
- **Category**: multi-chain, trading
- **Solana Support**: Solana network management, token operations, wallet connections, Orca/Jupiter/Raydium DEX trading

### ChainGuard
- **ID**: `chainguard`
- **GitHub**: https://github.com/N-45div/ChainGuard
- **Description**: AI-powered real-time blockchain crime detection and forensic analysis across Bitcoin, Ethereum, Hedera, and Solana. ML-powered pattern detection, risk scoring, cross-chain correlation.
- **Category**: multi-chain, security, forensics
- **Setup**:
  ```bash
  npx mcp-remote https://chainguard-mcp-server.ndivij2004.workers.dev/mcp
  ```
- **Solana Tools**: Pump & dump detection, wallet clustering, program analysis

### Phantom MCP (Multi-chain)
- **ID**: `phantom-mcp-server` (listed above in Wallets)
- **Note**: Supports both Solana and EVM chains (Ethereum, Base, Polygon, Arbitrum, etc.)

### Privy MCP (Multi-chain)
- **ID**: `privy-mcp-server` (listed above in Wallets)
- **Note**: Supports Ethereum, Solana, Bitcoin, and all EVM-compatible chains

---

## 13. Niche / Specialty MCP Servers

### solmail-mcp
- **ID**: `solmail-mcp`
- **GitHub**: https://github.com/ExpertVagabond/solmail-mcp
- **Description**: Send physical mail (letters, postcards) to 200+ countries using Solana cryptocurrency for payment (~$1.50 / 0.015 SOL for US domestic).
- **Category**: utility, payments

### deside-mcp
- **ID**: `deside-mcp`
- **Description**: Wallet-to-wallet messaging primitive for Solana agents via MCP. Agents authenticate with Ed25519 keypair and send DMs addressed by pubkey.
- **Category**: messaging, agent-infra
- **Listed in**: https://github.com/solana-foundation/awesome-solana-ai

### opendexter
- **ID**: `opendexter`
- **Description**: x402 search engine and payment gateway for AI agents. Search 5,000+ paid APIs, check pricing, pay with automatic USDC settlement. Available as MCP server (no auth needed) or npm package.
- **Category**: payments, discovery
- **Listed in**: https://github.com/solana-foundation/awesome-solana-ai

### breeze-agent-kit
- **ID**: `breeze-agent-kit`
- **Description**: Toolkit for building AI agents that manage Solana yield farming via the Breeze protocol. Four integration paths: MCP server, x402 payment-gated API, SKILL.md, and ClawHub one-command install.
- **Category**: defi, yield-farming
- **Listed in**: https://github.com/solana-foundation/awesome-solana-ai

### 1ly-mcp-server
- **ID**: `1ly-mcp-server`
- **GitHub**: https://github.com/1lystore/1ly-mcp-server
- **Description**: Enable AI agents to discover, launch tokens, pay for, and sell APIs/resources using x402 on Solana.
- **Category**: marketplace, payments

### x402-proxy
- **ID**: `x402-proxy`
- **GitHub**: https://github.com/cascade-protocol/x402-proxy
- **Description**: `curl` for x402 paid APIs. CLI + MCP proxy that auto-pays any endpoint on Base and Solana. Zero crypto code on buyer side. Works with Claude, Cursor, or any MCP client.
- **Category**: payments, proxy

---

## 14. Registries / Discovery

### aeamcp (openSVM Agent & MCP Server Registry)
- **ID**: `aeamcp`
- **GitHub**: https://github.com/openSVM/aeamcp
- **Description**: On-chain registry system for autonomous AI agents and MCP servers on Solana. Two registries: Agent Registry (AEA/A2A agents) and MCP Server Registry (tool/resource/prompt discovery). Live on Solana Devnet.
- **Category**: registry, infrastructure

### awesome-solana-mcp-servers (sendaifun)
- **ID**: `awesome-solana-mcp-servers`
- **GitHub**: https://github.com/sendaifun/awesome-solana-mcp-servers
- **Description**: Curated list of awesome Solana MCP servers and related resources.
- **Category**: registry, list

### awesome-solana-ai (Solana Foundation)
- **ID**: `awesome-solana-ai`
- **GitHub**: https://github.com/solana-foundation/awesome-solana-ai
- **Description**: Official Solana Foundation public repo of AI tooling to help build on Solana. Includes MCP servers, agent kits, and more.
- **Category**: registry, list

### awesome-solana-mcp (cryptoleek)
- **ID**: `cryptoleek-awesome-solana-mcp`
- **GitHub**: https://github.com/cryptoleek-team/awesome-solana-mcp
- **Description**: Another curated list of Solana MCP servers with focus on security and trading tools.
- **Category**: registry, list

---

## Summary by Category

| Category | Count | Notable Servers |
|----------|-------|-----------------|
| Infrastructure/RPC | 8 | solana-mcp-official, helius-mcp, openSVM, Chainstack, QuickNode |
| DeFi/DEX | 8 | Jupiter (3 impl.), Orca, Marinade, Metaplex Genesis, Solentic, DFlow |
| Wallet | 5 | Phantom, Privy, WalletMCP, Grandbusta, ExpertVagabond |
| Token Launch/Memecoin | 6 | PUMP-MCP, pumpfun (3 impl.), mcp-meme-deployer, memecoin-observatory |
| Trading/Sniping | 4 | 100ms Raydium Sniper, Quant72, 8bitsats Trading, Grok |
| Security/Rug Check | 5 | rug-check-mcp, cryptoleek, AetherCore, wallet-scanner, solana-fender |
| Data/Analytics | 9 | DexScreener (3 impl.), Spice/Flipside, Hubble, AMOCA, Forum Summarizer |
| Developer Tooling | 6 | anchor-mcp, web3js-mcp, SolMCP, omaidf, GOATsolana, caiovicentino |
| DAO/Governance | 2 | daoCLI, assetCLI |
| Multi-Chain | 4 | GOAT SDK, Hummingbot, ChainGuard, Phantom |
| Niche/Specialty | 6 | SolMail, Deside, OpenDexter, Breeze, 1ly, x402-proxy |
| Registries | 4 | aeamcp, awesome-solana-mcp-servers, awesome-solana-ai, cryptoleek-awesome |

---

## Sources

- [sendaifun/awesome-solana-mcp-servers](https://github.com/sendaifun/awesome-solana-mcp-servers)
- [solana-foundation/awesome-solana-ai](https://github.com/solana-foundation/awesome-solana-ai)
- [solana-foundation/solana-mcp-official](https://github.com/solana-foundation/solana-mcp-official)
- [sendaifun/solana-mcp](https://github.com/sendaifun/solana-mcp)
- [helius-labs/core-ai](https://github.com/helius-labs/core-ai)
- [Helius MCP Docs](https://www.helius.dev/docs/agents/mcp)
- [openSVM/solana-mcp-server](https://github.com/openSVM/solana-mcp-server)
- [Solana Developer MCP](https://mcp.solana.com/)
- [Phantom MCP Docs](https://docs.phantom.com/resources/mcp-server)
- [QuickNode MCP Docs](https://www.quicknode.com/docs/build-with-ai/quicknode-mcp)
- [Chainstack Solana MCP](https://docs.chainstack.com/docs/solana-mcp-server)
- [dcSpark/mcp-server-jupiter](https://github.com/dcSpark/mcp-server-jupiter)
- [araa47/jupiter-mcp](https://github.com/araa47/jupiter-mcp)
- [honey-guard/anchor-mcp](https://github.com/honey-guard/anchor-mcp)
- [goat-sdk/goat](https://github.com/goat-sdk/goat)
- [hummingbot/mcp](https://github.com/hummingbot/mcp)
- [openSVM/aeamcp](https://github.com/openSVM/aeamcp)
- [PulseMCP](https://www.pulsemcp.com)
- [mcpservers.org](https://mcpservers.org)
- [Glama MCP](https://glama.ai/mcp/servers)
