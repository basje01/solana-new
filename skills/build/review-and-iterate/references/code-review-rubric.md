# Code Review Rubric

Scoring dimensions for Solana project quality.

## Dimensions (A-F scale)

### 1. Correctness
- Does the code do what it claims?
- Are edge cases handled?
- Are transactions properly confirmed?
- Are token amounts handled with correct decimals?

### 2. Security
- See security-basics.md for the full checklist
- Any critical finding drops the overall grade to C or below

### 3. Code Organization
- Clear separation of concerns
- Consistent naming conventions
- No dead code or commented-out blocks
- Functions are focused (single responsibility)

### 4. Error Handling
- Meaningful error messages
- No swallowed errors (empty catch blocks)
- Transaction failures handled gracefully
- User-facing errors are human-readable

### 5. Testing
- Core paths have test coverage
- Tests run against devnet or local validator
- Tests are deterministic (no flaky network calls without mocks)

### 6. Documentation
- README explains setup and usage
- Complex logic has inline comments
- API/program interfaces are documented
- Environment variables are documented in .env.example

## Overall Grade

- **A**: Excellent across all dimensions, production-ready
- **B**: Good overall, minor improvements needed
- **C**: Functional but has significant gaps
- **D**: Works but has security or quality concerns
- **F**: Not ready — critical issues found
