# Gas Optimization

Reducing compute units and transaction costs on Solana.

## Compute Unit (CU) Budget

- Default: 200,000 CU per instruction
- Max: 1,400,000 CU per transaction
- Each CU costs ~0.000001 SOL at base fee (+ priority fee)

## Quick Wins

### 1. Minimize Account Reads
- Each account deserialization costs CU
- Only include accounts that are actually used
- Use `AccountInfo` instead of full deserialization when you only need lamports/owner

### 2. Avoid Unnecessary Logging
- `msg!()` in programs costs CU
- Remove debug logs in production builds
- Use `#[cfg(feature = "debug")]` for conditional logging

### 3. Efficient Data Structures
- Use fixed-size arrays instead of vectors where possible
- Pack related fields to minimize account size
- Use bitflags for boolean fields

### 4. CPI Optimization
- Each CPI call adds overhead
- Batch operations when possible instead of multiple CPIs
- Use `invoke_signed` efficiently — don't re-derive PDA seeds unnecessarily

### 5. Account Size
- Rent cost is proportional to account size
- Only allocate what you need
- Consider using zero-copy deserialization for large accounts

## When to Optimize

- **During MVP**: Don't optimize. Ship fast, optimize later.
- **Before mainnet**: Profile CU usage, optimize hot paths.
- **After launch**: Optimize based on actual usage patterns, not assumptions.

## Tools

- `solana logs` — see CU usage per instruction
- Anchor's `#[event]` — lighter than `msg!()` for structured logging
- Helius transaction inspector — detailed CU breakdown
