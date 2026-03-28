# Program Upgrade Guide

Managing Solana program deployments and upgrades.

## Initial Deployment

```bash
# Build the program
anchor build

# Deploy to mainnet
anchor deploy --provider.cluster mainnet

# Record the program ID
anchor keys list
```

## Upgrade Authority

### Option 1: Keep Upgradeable (recommended for early projects)
- You can fix bugs and add features
- Users must trust your authority wallet
- Use a multisig (Squads) for the authority

### Option 2: Freeze (immutable)
- No one can change the program ever
- Maximum trustlessness
- Only do this when the program is battle-tested

```bash
# To freeze (IRREVERSIBLE):
solana program set-upgrade-authority <PROGRAM_ID> --final
```

### Option 3: Transfer Authority
- Move authority to a DAO or multisig
- Good for decentralization roadmaps

```bash
solana program set-upgrade-authority <PROGRAM_ID> \
  --new-upgrade-authority <NEW_AUTHORITY>
```

## Upgrade Process

```bash
# 1. Build new version
anchor build

# 2. Verify the build (compare hashes)
sha256sum target/deploy/my_program.so

# 3. Deploy upgrade
anchor upgrade <PROGRAM_ID> --program-filepath target/deploy/my_program.so

# 4. Verify on-chain
solana program show <PROGRAM_ID>
```

## Safety Rules

1. **Always test the upgrade on devnet first** with the same process
2. **Back up the current program binary** before upgrading
3. **Account migration**: If you changed account structures, write a migration
4. **Notify users**: If the upgrade changes behavior, communicate first
5. **Monitor after upgrade**: Watch for errors in the first hour
