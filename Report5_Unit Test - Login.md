# Report 5 - Login Service Unit Test

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-01 | Function Name | `authService.login(email, password)` |
| Created By | Pham Hai Dang | Executed By | Codex / Jest (automated) |
| Lines of code | 28 | Lack of test cases | -16.2 |
| Test requirement | Authenticate the supplied email and password; allow ACTIVE accounts; generate a BE session ID; write lastLoginAt and create tokens atomically; return { account, tokens } or reject with the actual exception. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 19 | 0 | 0 | 5 | 12 | 2 | 19 |

## Shared preconditions

The complete setup below is installed unchanged for every test case. Selecting another email selects another record from the same catalogue; it does not change the preconditions. Only `authService.login(email, password)` is the unit under test.

| Email | Role | Status | Stored password before hashing |
| --- | --- | --- | --- |
| `admin@example.com` | `ADMIN` | `ACTIVE` | `"Login123!"` |
| `owner@example.com` | `FARM_OWNER` | `ACTIVE` | `"Login123!"` |
| `technician@example.com` | `TECHNICIAN` | `ACTIVE` | `"Login123!"` |
| `expert@example.com` | `EXPERT` | `ACTIVE` | `"Login123!"` |
| `short@example.com` | `FARM_OWNER` | `ACTIVE` | `"x"` |
| `spaces@example.com` | `FARM_OWNER` | `ACTIVE` | `" Login123! "` |
| `pending@example.com` | `FARM_OWNER` | `PENDING_ACTIVATION` | `null` (no password hash) |
| `blocked@example.com` | `FARM_OWNER` | `BLOCKED` | `"Login123!"` |
| `inactive@example.com` | `FARM_OWNER` | `INACTIVE` | `"Login123!"` |
| `update-error@example.com` | `FARM_OWNER` | `ACTIVE` | `"Login123!"` |
| `token-error@example.com` | `FARM_OWNER` | `ACTIVE` | `"Login123!"` |

All passwords except `null` are hashed with real bcrypt before execution. `missing@example.com` has no record. Account IDs are fixed UUIDs in the shared fixture. Technician and Expert reference the Owner fixture. Initially, every account has `lastLoginAt: null`; pending activation also has `fullName`, `activatedAt`, and `passwordHash` set to `null`. Other accounts are activated and have the same prepared public profile fields.

The real service, bcrypt comparison, and UUID generation run. Prisma and `tokenService.generateAuthTokens` are mocked at their dependency boundaries. The same rules apply to every case:

- Account lookup returns the record selected by email, or `null` if absent. Lookup of `lookup-error@example.com` rejects with `Error("Account lookup failed")`.
- The transaction executes the real service callback with a mocked transaction client. Account update normally resolves; updating `update-error@example.com` rejects with `Error("Last login update failed")`.
- Token generation normally resolves to `{ accessToken: "fixture-access-token", refreshToken: "fixture-refresh-token" }`; for `token-error@example.com`, it rejects with `Error("Token generation failed")`.
- Every case starts with reset mocks. No live database is used in these unit tests.

`email` and `password` are the complete function arguments. The BE creates `deviceId` internally; it is not a test parameter. The Return value is `{ account, tokens }`: `account` excludes `passwordHash` and contains the written `lastLoginAt`; `tokens` is the exact dependency-provided object.

## Unit test matrix

`O` marks the applicable input or expected outcome. Every precondition row is common to all columns. A blank Return cell means that the promise rejects. `P` means the actual outcome matched the expectation, including an expected exception. Exception rows contain literal error messages. No exception is expected in successful cases.

| Section | Item | UTCID01 | UTCID02 | UTCID03 | UTCID04 | UTCID05 | UTCID06 | UTCID07 | UTCID08 | UTCID09 | UTCID10 | UTCID11 | UTCID12 | UTCID13 | UTCID14 | UTCID15 | UTCID16 | UTCID17 | UTCID18 | UTCID19 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  | Scenario | Active Admin with matching credentials | Active Farm Owner with matching credentials | Active Technician with matching credentials | Active Expert with matching credentials | One-character password matches the stored password | Empty password does not match the stored password | Account does not exist | Incorrect password | Pending account has no stored password hash | Blocked account with matching password | Inactive account with matching password | Blocked account with incorrect password | Inactive account with incorrect password | Password case differs from the stored password | Extra password spaces do not match the stored password | Matching password containing spaces is preserved | Account lookup dependency rejects | Last-login update dependency rejects | Token generation dependency rejects |
| Condition | Precondition: the complete shared account catalogue is prepared | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | Precondition: real bcrypt comparison and UUID generation are available | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | Precondition: the shared Prisma and token dependency rules are installed | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | Precondition: mocks are reset; no live database is used | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O | O |
|  | **Email** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"admin@example.com"` | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"owner@example.com"` |  | O |  |  |  | O |  | O |  |  |  |  |  | O | O |  |  |  |  |
|  | `"technician@example.com"` |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"expert@example.com"` |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"short@example.com"` |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"missing@example.com"` |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"pending@example.com"` |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |
|  | `"blocked@example.com"` |  |  |  |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |  |
|  | `"inactive@example.com"` |  |  |  |  |  |  |  |  |  |  | O |  | O |  |  |  |  |  |  |
|  | `"spaces@example.com"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
|  | `"lookup-error@example.com"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |
|  | `"update-error@example.com"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |
|  | `"token-error@example.com"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |
|  | **Password** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"Login123!"` | O | O | O | O |  |  | O |  | O | O | O |  |  |  |  |  | O | O | O |
|  | `"x"` |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `""` |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"Wrong123!"` |  |  |  |  |  |  |  | O |  |  |  | O | O |  |  |  |  |  |  |
|  | `"login123!"` |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |
|  | `" Login123! "` |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O | O |  |  |  |
| Confirm | **Return**: `{ account, tokens }` | O | O | O | O | O |  |  |  |  |  |  |  |  |  |  | O |  |  |  |
|  | **Exception** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|  | `"Email or password is incorrect"` |  |  |  |  |  | O | O | O | O |  |  | O | O | O | O |  |  |  |  |
|  | `"Your account has been blocked. Please contact support"` |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |  |
|  | `"Your account is inactive. Please contact support"` |  |  |  |  |  |  |  |  |  |  | O |  |  |  |  |  |  |  |  |
|  | `"Account lookup failed"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |  |
|  | `"Last login update failed"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |  |
|  | `"Token generation failed"` |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | O |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) | N | N | N | N | B | B | A | A | A | A | A | A | A | A | A | N | A | A | A |
|  | Passed/Failed | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P |
|  | Executed Date | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 |
|  | Defect ID |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

## Execution evidence

Executed on 2026-11-09 at 23:16:38 (Asia/Ho_Chi_Minh). Jest reported **19 passed, 0 failed, 0 untested** for the single service unit suite. The matrix and counts above were generated only after matching every case ID and title against that execution result.

From `smartshrimp_be`, run:

```powershell
node node_modules/jest/bin/jest.js --runInBand --runTestsByPath tests/login.service.test.js
```

Credential rejections use `ApiError` 401; matching credentials for blocked or inactive accounts use `ApiError` 403. The pending account has no password hash, so it returns the same invalid-credentials message as an unknown account. Dependency errors are controlled test fixtures and propagate unchanged; their literal messages are not additional Login business messages.

The two B cases exercise zero- and one-character password inputs against the prepared hashes. They do not claim that this service enforces password length. Concurrency changes, transaction conflict/retry scenarios, and bcrypt byte-limit scenarios are outside the agreed scope. Unknown account statuses are excluded because the database enum does not permit them.

Lines of code counts nonblank, noncomment lines in the Login function, including its declaration and closing line. Lack of test cases preserves the supplied template calculation: `(Lines of code * 100 / 1000) - Total Test Cases`; a negative value is the formula result, not a missing-case count.

Sources: [service](smartshrimp_be/src/services/auth.service.js), [unit tests](smartshrimp_be/tests/login.service.test.js), [shared fixtures and cases](smartshrimp_be/tests/support/loginServiceCases.cjs).
