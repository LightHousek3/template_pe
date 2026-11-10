# Report 5 - Forgot Password (ResetPassword Service)

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-03 | Function Name | `verificationService.resetPassword({ actionToken, password })` |
| Created By | Pham Hai Dang | Executed By | Pham Hai Dang |
| Lines of code | 58 | Lack of test cases | -1.2 |
| Test requirement | Complete a valid reset; reject unknown, used or expired tokens and blocked/inactive accounts; consume the token and revoke existing sessions. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 7 | 0 | 0 | 1 | 5 | 1 | 7 |

Unit: `verificationService.resetPassword({ actionToken, password })`, the completion step of Forgot Password. `O` selects a condition, input or expected result; `P` means passed. Password is fixed for every case; no password-variation cases are included.

| Section | Item | UTCID01 | UTCID02 | UTCID03 | UTCID04 | UTCID05 | UTCID06 | UTCID07 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | Scenario | Complete a valid password reset | Action token does not exist | Action token has already been used | Action token has reached its expiry time | Account is blocked | Account is inactive | Action token has one valid millisecond remaining |
| Condition | **Precondition** |  |  |  |  |  |  |  |
|  | Can connect with server | O | O | O | O | O | O | O |
|  | Token service is available | O | O | O | O | O | O | O |
|  | Account status = "ACTIVE" | O |  | O | O |  |  | O |
|  | Account status = "BLOCKED" |  |  |  |  | O |  |  |
|  | Account status = "INACTIVE" |  |  |  |  |  | O |  |
|  | **Action token** |  |  |  |  |  |  |  |
|  | `actionToken_valid = "tok_valid"` | O |  |  |  |  |  |  |
|  | `actionToken_not_found = "tok_missing"` |  | O |  |  |  |  |  |
|  | `actionToken_consumed = "tok_used"` |  |  | O |  |  |  |  |
|  | `actionToken_expired = "tok_expired"` |  |  |  | O |  |  |  |
|  | `actionToken_blocked = "tok_blocked"` |  |  |  |  | O |  |  |
|  | `actionToken_inactive = "tok_inactive"` |  |  |  |  |  | O |  |
|  | `actionToken_last_valid_ms = "tok_last_ms"` |  |  |  |  |  |  | O |
|  | **Password** |  |  |  |  |  |  |  |
|  | `password_valid = "ResetPass456!"` | O | O | O | O | O | O | O |
| Confirm | **Return**: `undefined` | O |  |  |  |  |  | O |
|  | **Exception (English description of the unchanged runtime error)** |  |  |  |  |  |  |  |
|  | The verification session is invalid or has expired |  | O | O | O |  |  |  |
|  | Your account has been blocked. Please contact support |  |  |  |  | O |  |  |
|  | Your account is inactive. Please contact support |  |  |  |  |  | O |  |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) | N | A | A | A | A | A | B |
|  | Passed/Failed | P | P | P | P | P | P | P |
|  | Executed Date | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 |
|  | Defect ID |  |  |  |  |  |  |  |

All prepared accounts are Farm Owners. Test time is fixed at 2026-11-10T00:00:00.000Z: tok_expired expires at that instant (A); tok_last_ms expires 1 ms later (B). Short token strings are the exact synthetic inputs used by these service tests; token-format validation is outside this unit.

Exception rows are English descriptions of unchanged Vietnamese runtime messages. Tests assert the exact runtime messages, status codes and error codes. Successful cases verify the password update, token consumption, challenge invalidation and awaited session revocation using the same transaction client. Server availability is assumed; database and token-service boundaries are mocked.

Scope: selected main-flow cases. Password variations, other roles/purposes, pending activation, superseded tokens, concurrent updates and expiry during processing are outside this report. This is not exhaustive branch coverage.

Executed on 2026-11-10 at 15:49:57 (Asia/Ho_Chi_Minh): **7 passed, 0 failed, 0 untested**. Every matrix column was matched to its executed Jest case.

```powershell
node node_modules/jest/bin/jest.js --runInBand --runTestsByPath tests/resetPassword.service.test.js
```

Lines of code = 58: nonblank, noncomment physical lines of completeVerification in verification.service.js (lines 138-196), including its declaration and braces. This is the real business implementation reached through the one-line resetPassword export. The shared function also contains activation code; only its PASSWORD_RESET flow is tested here. Helpers and external libraries are not added recursively.

The supplied workbook maps Forgot Password to UT-03 at Functions!E13 and has 100 test cases/KLOC at Functions!E6. Its Login!L4 formula is LOC * norm / 1000 - total cases. Lack of test cases = 58 * 100 / 1000 - 7 = -1.2. Negative and fractional results are preserved; this density measure does not establish branch coverage.

Sources: [service](smartshrimp_be/src/services/verification.service.js), [unit tests](smartshrimp_be/tests/resetPassword.service.test.js), [fixtures and expected runtime messages](smartshrimp_be/tests/support/resetPasswordServiceCases.cjs).
