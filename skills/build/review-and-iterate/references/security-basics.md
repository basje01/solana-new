# Security Basics

Solana-specific security checklist. Every program review must check these.

## Critical Checks (P0)

### 1. Signer Verification
- Every privileged instruction checks that the correct account signed
- In Anchor: `#[account(signer)]` or `Signer` type
- Missing signer checks = anyone can call your admin functions

### 2. Account Ownership
- Verify accounts are owned by the expected program
- In Anchor: `#[account(owner = expected_program)]`
- Without this, attackers can pass fake accounts

### 3. PDA Validation
- PDA seeds must be deterministic and include enough entropy
- Always re-derive the PDA in the instruction handler, don't trust the client
- Check for PDA seed collisions in multi-tenant designs

### 4. Arithmetic Safety
- Use checked math (`checked_add`, `checked_mul`) or Anchor's built-in checks
- Overflow/underflow in token calculations = loss of funds

### 5. Reinitialization Protection
- Accounts that should be initialized once must check an `is_initialized` flag
- In Anchor: `init` constraint handles this, but custom programs must check manually

## Important Checks (P1)

### 6. Rent Drain
- Don't allow closing accounts without reclaiming rent to the right recipient
- Check that `close` targets are validated

### 7. Duplicate Account Aliasing
- If an instruction takes multiple accounts, verify they're not the same account
- Same-account aliasing can break invariants

### 8. CPI Authority
- When doing cross-program invocations, ensure the signing PDA has minimal authority
- Don't give CPI callers more power than needed

### 9. Front-running
- Consider if transaction ordering matters for your logic
- Use commit-reveal or time locks for sensitive operations

## Client-Side Security

- Never expose private keys in frontend code
- Never commit .env files with real keys
- Use environment variables for all secrets
- Validate user input before sending transactions
