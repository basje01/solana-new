# Testing Checklist

What to verify before declaring MVP done.

## Functionality

- [ ] Core feature works on devnet with a fresh wallet
- [ ] Error states are handled (insufficient balance, wrong input, network failure)
- [ ] Transaction confirmations are waited for (not fire-and-forget)
- [ ] Token amounts display with correct decimals

## Security (Minimum)

- [ ] No private keys in code or environment files committed to git
- [ ] PDA seeds are deterministic and collision-resistant
- [ ] Account ownership is verified in program instructions
- [ ] Signer checks are in place for privileged operations
- [ ] No unchecked arithmetic in on-chain programs

## UX (if frontend)

- [ ] Wallet connect/disconnect works
- [ ] Loading states shown during transactions
- [ ] Error messages are human-readable
- [ ] Works with at least Phantom and Solflare wallets

## DevOps

- [ ] `.env.example` has all required variables documented
- [ ] `pnpm install && pnpm build` works from a clean clone
- [ ] README has setup instructions
- [ ] Program is deployed to devnet with a stable address
