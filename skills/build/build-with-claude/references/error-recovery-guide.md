# Error Recovery Guide

Common Solana development errors and how to fix them.

## Transaction Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `BlockhashNotFound` | Transaction expired | Get fresh blockhash, retry |
| `InsufficientFundsForRent` | Account below rent-exempt minimum | Add more lamports |
| `AccountNotFound` | Reading account that doesn't exist | Check if account is initialized |
| `ProgramFailedToComplete` | Exceeded compute budget | Add `ComputeBudgetProgram.setComputeUnitLimit()` |
| `TransactionTooLarge` | Transaction exceeds 1232 bytes | Split into multiple transactions or use lookup tables |

## Anchor Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `AccountNotInitialized` | Using `init` on existing account | Use `init_if_needed` or check first |
| `ConstraintSeeds` | PDA seeds don't match | Verify seeds match between client and program |
| `ConstraintOwner` | Wrong program owns the account | Check account ownership |
| `DeclaredProgramIdMismatch` | Program ID in code ≠ deployed | Run `anchor keys sync` |

## Build Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `anchor build` fails with BPF error | Old Solana CLI version | `solana-install update` |
| `pnpm install` hangs | Node version mismatch | Use Node 18+ |
| IDL type mismatch | Stale IDL after program change | Rebuild: `anchor build && anchor idl parse` |

## Debug Strategy

1. Read the full error message — Solana errors are usually descriptive
2. Check the transaction on Solana Explorer (devnet)
3. Use `connection.simulateTransaction()` for detailed logs
4. Add `msg!()` logs in Anchor programs and read with `solana logs`
