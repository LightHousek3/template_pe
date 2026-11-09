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

All cases test only `authService.login(email, password)` and use the same prepared account catalogue and dependency rules. Preconditions are listed together in the matrix. `O` marks the selected condition, input or expected outcome; `P` means passed. A blank Return cell means the promise rejects.

| Section | Item | UTCID01 | UTCID02 | UTCID03 | UTCID04 | UTCID05 | UTCID06 | UTCID07 | UTCID08 | UTCID09 | UTCID10 | UTCID11 | UTCID12 | UTCID13 | UTCID14 | UTCID15 | UTCID16 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | Scenario | Active account with matching credentials | One-character password matches the stored password | Empty password does not match the stored password | Account does not exist | Incorrect password | Pending account has no stored password hash | Blocked account with matching password | Inactive account with matching password | Blocked account with incorrect password | Inactive account with incorrect password | Password case differs from the stored password | Extra password spaces do not match the stored password | Matching password containing spaces is preserved | Account lookup dependency rejects | Last-login update dependency rejects | Token generation dependency rejects |
| Condition | **Precondition** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Account lookup is available and completes successfully | O | O | O | O | O | O | O | O | O | O | O | O | O |  | O | O |
|  | Account lookup throws "Account lookup failed" |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |
|  | Account does not exist for the supplied email |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Account status = ACTIVE | O | O | O |  | O |  |  |  |  |  | O | O | O |  | O | O |
|  | Account status = PENDING_ACTIVATION |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |
|  | Account status = BLOCKED |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |  |
|  | Account status = INACTIVE |  |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |
|  | Account passwordHash is a bcrypt hash of `"Login123!"` | O |  | O |  | O |  | O | O | O | O | O | O |  |  | O | O |
|  | Account passwordHash is a bcrypt hash of `"x"` |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | Account passwordHash is a bcrypt hash of `" Login123! "` |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
|  | Account passwordHash = null |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |
|  | Account update is available and succeeds | O | O | O | O | O | O | O | O | O | O | O | O | O | O |  | O |
|  | Account update throws "Last login update failed" |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |
|  | Token service is available and generates auth tokens successfully | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |  |
|  | Token service throws "Token generation failed" |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |
|  | **Email** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"active@example.com"` | O |  | O |  | O |  |  |  |  |  | O | O |  |  |  |  |
|  | `"short@example.com"` |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"missing@example.com"` |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"pending@example.com"` |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |
|  | `"blocked@example.com"` |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |  |
|  | `"inactive@example.com"` |  |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |
|  | `"spaces@example.com"` |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
|  | `"lookup-error@example.com"` |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |
|  | `"update-error@example.com"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |
|  | `"token-error@example.com"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |
|  | **Password** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"Login123!"` | O |  |  | O |  | O | O | O |  |  |  |  |  | O | O | O |
|  | `"x"` |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `""` |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"Wrong123!"` |  |  |  |  | O |  |  |  | O | O |  |  |  |  |  |  |
|  | `"login123!"` |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |
|  | `" Login123! "` |  |  |  |  |  |  |  |  |  |  |  | O | O |  |  |  |
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

Dependency preconditions describe the prepared behavior if called. Login calls account update and token generation only after the password and account status checks pass. Dependency failure messages above are controlled test fixtures; Login propagates those errors unchanged.

Tests run the real Login function and bcrypt comparison, with Prisma and token generation mocked. Successful returns are checked for the public account without passwordHash, the written lastLoginAt, and the exact tokens provided by the token service.

The B cases use zero- and one-character passwords; Login itself does not enforce password length. The pending account has no password hash and therefore receives "Email or password is incorrect".

Executed on 2026-11-09 at 23:39:35 (Asia/Ho_Chi_Minh): **16 passed, 0 failed, 0 untested**. Every column was matched to its executed Jest case before this report was generated.

```powershell
node node_modules/jest/bin/jest.js --runInBand --runTestsByPath tests/login.service.test.js
```

Lines of code counts nonblank, noncomment lines in Login. Lack of test cases follows the supplied template formula: `(Lines of code * 100 / 1000) - Total Test Cases`.

Sources: [service](smartshrimp_be/src/services/auth.service.js), [unit tests](smartshrimp_be/tests/login.service.test.js), [fixtures and cases](smartshrimp_be/tests/support/loginServiceCases.cjs).
