# Report 5 - ResetPassword Service Unit Test

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-02 | Function Name | `verificationService.resetPassword({ actionToken, password })` |
| Created By | Pham Hai Dang | Executed By | Codex / Jest (automated) |
| Lines of code | 1 (exported wrapper; real shared implementation exercised) | Lack of test cases | Not calculated (KLOC norm not specified) |
| Test requirement | Check reset tokens and account eligibility; consume the token once; replace the password; invalidate remaining challenges; revoke all account refresh tokens; resolve to undefined. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 21 | 0 | 0 | 5 | 14 | 2 | 21 |

Only `verificationService.resetPassword` is called. Its shared password-reset implementation and policy checks run unchanged. All cases use one prepared catalogue. `O` marks the selected condition, input or expected outcome; `P` means passed. A blank Return cell means the function rejects.

Exception rows are **English descriptions**, not replacement runtime messages. The BE messages remain Vietnamese, and the executed tests assert those exact original strings, error codes and status codes.

| Section | Item | UTCID01 | UTCID02 | UTCID03 | UTCID04 | UTCID05 | UTCID06 | UTCID07 | UTCID08 | UTCID09 | UTCID10 | UTCID11 | UTCID12 | UTCID13 | UTCID14 | UTCID15 | UTCID16 | UTCID17 | UTCID18 | UTCID19 | UTCID20 | UTCID21 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | Scenario | Reset an active Farm Owner password | Reset an active Technician password | Reset an active Expert password | New password equals the current password (allowed by the function) | Preserve spaces in the new password | Action token does not exist | Action token belongs to account activation | Action token has already been used | Action token has been superseded | Action token expired one millisecond ago | Action token expiry equals the current time | Action token has one valid millisecond remaining | Action token belongs to an unsupported Admin account | Account is blocked | Account is inactive | Account is pending activation | Action token cannot be consumed by the conditional update | Account no longer matches the reset update conditions | Action token expires at the final check after password hashing | Expired action token stays generic for a blocked account | Used action token stays generic for an inactive account |
| Condition | **Precondition** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Can connect with server | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | Token service is available and revokes all account refresh tokens successfully | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | Current time is fixed at "2026-11-10T00:00:00.000Z" | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | Account status = "ACTIVE" | O | O | O | O | O |  |  | O | O | O | O | O | O |  |  |  | O | O | O |  |  |
|  | Account status = "BLOCKED" |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  | O |  |
|  | Account status = "INACTIVE" |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  | O |
|  | Account status = "PENDING_ACTIVATION" |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  | O |  |  |  |  |  |
|  | Account role = "FARM_OWNER" | O |  |  | O | O |  | O | O | O | O | O | O |  | O | O | O | O | O | O | O | O |
|  | Account role = "TECHNICIAN" |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Account role = "EXPERT" |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Account role = "ADMIN" |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |
|  | Action token purpose = "PASSWORD_RESET" | O | O | O | O | O |  |  | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | Action token purpose = "ACCOUNT_ACTIVATION" |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Action token is verified and has not expired | O | O | O | O | O |  | O |  |  |  |  |  | O | O | O | O | O | O |  |  |  |
|  | Action token does not exist |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Action token has already been used |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  | O |
|  | Action token has been superseded |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Action token expiry = current time - 1 ms |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  | O |  |
|  | Action token expiry = current time |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |
|  | Action token expiry = current time + 1 ms |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  | O |  |  |
|  | Action token expires before the final check after password hashing |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |
|  | Action token cannot be consumed by the conditional update |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |
|  | Account no longer matches the password-reset update conditions |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
|  | **Action token** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_valid_owner = "AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE"` | O |  |  | O | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_valid_technician = "AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI"` |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_valid_expert = "AwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM"` |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_not_found = "-vr6-vr6-vr6-vr6-vr6-vr6-vr6-vr6-vr6-vr6-vo"` |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_wrong_purpose = "BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQ"` |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_consumed = "BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU"` |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_superseded = "BgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgY"` |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_expired = "BwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwc"` |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_expires_now = "CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg"` |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |
|  | `actionToken_last_valid_ms = "CQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQk"` |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |
|  | `actionToken_unsupported_role = "CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgo"` |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |
|  | `actionToken_blocked = "CwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCws"` |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |
|  | `actionToken_inactive = "DAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |
|  | `actionToken_pending = "DQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |
|  | `actionToken_not_consumable = "Dg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |
|  | `actionToken_account_update_not_matched = "Dw8PDw8PDw8PDw8PDw8PDw8PDw8PDw8PDw8PDw8PDw8"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
|  | `actionToken_expires_during_reset = "EBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |
|  | `actionToken_blocked_expired = "ERERERERERERERERERERERERERERERERERERERERERE"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |
|  | `actionToken_inactive_consumed = "EhISEhISEhISEhISEhISEhISEhISEhISEhISEhISEhI"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |
|  | **Password** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `password_new = "ResetPass456!"` | O | O | O |  |  | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | `password_current = "CurrentPass123!"` |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `password_with_spaces = " ResetPass456! "` |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Confirm | **Return**: `undefined` | O | O | O | O | O |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |
|  | **Exception (English description of the unchanged runtime error)** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | The verification session is invalid or has expired |  |  |  |  |  | O | O | O | O | O | O |  | O |  |  |  | O |  | O | O | O |
|  | Your account has been blocked. Please contact support |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |
|  | Your account is inactive. Please contact support |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |
|  | Account has not been activated. Please activate your account first |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |
|  | The verification request is being processed. Please try again |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) | N | N | N | N | N | A | A | A | A | A | A | B | A | A | A | A | A | A | B | A | A |
|  | Passed/Failed | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P |
|  | Executed Date | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 |
|  | Defect ID |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

The B cases start at the last valid millisecond before token expiry. One completes with time held fixed; the other reaches expiry before the final token check and must reject. Tokens already at or past expiry are A. Password-length rules belong to validation and are not classified as service boundaries.

Successful cases also verify the stored password, one-time token consumption, invalidation of remaining challenges, and all-session revocation with the same transaction client. Reset must wait for revocation to complete. The function returns no account, token or success-message payload.

The unchanged implementation permits the new password to equal the current password and preserves password spaces. The zero-match conditional updates are explicit checks in this function; no database, email or token-service exceptions are injected.

Server availability is an assumed precondition. Database and token-service boundaries are mocked. Only SQL-permitted account and challenge states are prepared; impossible stored records are not fabricated to exercise defensive guards.

Executed on 2026-11-10 at 03:28:39 (Asia/Ho_Chi_Minh): **21 passed, 0 failed, 0 untested**. Every matrix column was matched to its executed Jest case.

```powershell
node node_modules/jest/bin/jest.js --runInBand --runTestsByPath tests/resetPassword.service.test.js
```

Sources: [service](smartshrimp_be/src/services/verification.service.js), [unit tests](smartshrimp_be/tests/resetPassword.service.test.js), [fixtures and expected runtime messages](smartshrimp_be/tests/support/resetPasswordServiceCases.cjs).
