# Report 5 - Login Service Unit Test

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-01 | Function Name | `authService.login(email, password)` |
| Created By | Pham Hai Dang | Executed By | Codex / Jest (automated) |
| Lines of code | 28 | Lack of test cases | -13.2 |
| Test requirement | Check email, password and account status; generate a BE session ID; update lastLoginAt; return { account, tokens } or the actual exception. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 16 | 0 | 0 | 2 | 12 | 2 | 16 |

Function under test: `authService.login(email, password)`. `O` marks the selected condition, input or expected outcome. `P` means passed. A blank Return cell means the function rejects.

| Section | Item | UTCID01 | UTCID02 | UTCID03 | UTCID04 | UTCID05 | UTCID06 | UTCID07 | UTCID08 | UTCID09 | UTCID10 | UTCID11 | UTCID12 | UTCID13 | UTCID14 | UTCID15 | UTCID16 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | Scenario | Valid login | One-character stored password | Empty password | Unregistered email | Wrong password | Pending account | Blocked account | Inactive account | Blocked account, wrong password | Inactive account, wrong password | Password case mismatch | Extra password spaces | Matching password with spaces | Account lookup fails | Account update fails | Token generation fails |
| Condition | **Precondition** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Can connect with server | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | Token service is available and generates auth tokens successfully | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |  |
|  | Token service fails to generate auth tokens |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |
|  | Account status = ACTIVE | O | O | O |  | O |  |  |  |  |  | O | O | O |  | O | O |
|  | Account status = PENDING_ACTIVATION |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |
|  | Account status = BLOCKED |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |  |
|  | Account status = INACTIVE |  |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |
|  | **Email** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `email_valid = active@example.com` | O |  | O |  | O |  |  |  |  |  | O | O |  |  |  |  |
|  | `email_short_password = short@example.com` |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `email_not_registered = missing@example.com` |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `email_pending = pending@example.com` |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |
|  | `email_blocked = blocked@example.com` |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |  |
|  | `email_inactive = inactive@example.com` |  |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |
|  | `email_spaced_password = spaces@example.com` |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
|  | `email_lookup_error = lookup-error@example.com` |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |
|  | `email_update_error = update-error@example.com` |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |
|  | `email_token_error = token-error@example.com` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |
|  | **Password** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `password_valid = Login123!` | O |  |  | O |  | O | O | O |  |  |  |  |  | O | O | O |
|  | `password_len_1_valid = x` |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `password_empty = ""` |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `password_wrong = Wrong123!` |  |  |  |  | O |  |  |  | O | O |  |  |  |  |  |  |
|  | `password_wrong_case = login123!` |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |
|  | `password_extra_spaces_invalid = " Login123! "` |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |
|  | `password_with_spaces_valid = " Login123! "` |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
| Confirm | **Return**: `{ account, tokens }` | O | O |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
|  | **Exception** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"Email or password is incorrect"` |  |  | O | O | O | O |  |  | O | O | O | O |  |  |  |  |
|  | `"Your account has been blocked. Please contact support"` |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |
|  | `"Your account is inactive. Please contact support"` |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |
|  | `"Account lookup failed"` |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |
|  | `"Last login update failed"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |
|  | `"Token generation failed"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) | N | B | B | A | A | A | A | A | A | A | A | A | N | A | A | A |
|  | Passed/Failed | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P |
|  | Executed Date | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 |
|  | Defect ID |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

Server availability is an assumed precondition; unit tests call Login directly. Token service conditions describe its prepared behavior if called. The three error emails select controlled failure fixtures.

The B cases use empty and one-character passwords. Login checks the supplied password against the stored password; it does not enforce password length. A value marked valid matches the selected account.

Executed on 2026-11-09 at 23:56:05 (Asia/Ho_Chi_Minh): **16 passed, 0 failed, 0 untested**. Every column was matched to its executed Jest case before this report was generated.

```powershell
node node_modules/jest/bin/jest.js --runInBand --runTestsByPath tests/login.service.test.js
```

Lines of code counts nonblank, noncomment lines in Login. Lack of test cases follows the supplied template formula: `(Lines of code * 100 / 1000) - Total Test Cases`.

Sources: [service](smartshrimp_be/src/services/auth.service.js), [unit tests](smartshrimp_be/tests/login.service.test.js), [fixtures and cases](smartshrimp_be/tests/support/loginServiceCases.cjs).
