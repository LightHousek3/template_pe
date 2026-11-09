# Report 5 - Login Service Unit Test

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-01 | Function Name | `authService.login(email, password, deviceId)` |
| Created By | Pham Hai Dang | Executed By | Codex / Jest (automated) |
| Lines of code | 40 | Lack of test cases | -14 |
| Test requirement | Authenticate against the stored account and password hash; allow ACTIVE accounts; resolve the public account and dependency-provided tokens; propagate the expected exceptions. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 18 | 0 | 0 | 6 | 11 | 1 | 18 |

## Scope and notation

The only function under test is `authService.login(email, password, deviceId)` in `src/services/auth.service.js`. Preconditions describe the prepared account records and dependency behavior. Test data contains all three function arguments: `email`, `password`, and `deviceId`.

`O` marks an applicable prepared condition or an asserted expected result. A blank cell means that the row does not apply to that case. `P` means that the observed result matched the expectation, including an expected rejection. `N` = Normal, `A` = Abnormal, and `B` = Boundary.

The Return section describes the resolved value. For a rejected promise, Return is left unmarked and the exception is marked under Exception. Exception message values use their exact source constant names; existing runtime strings are not translated.

The agreed main-flow scope excludes concurrent password/status changes, transaction conflicts, and bcrypt byte-limit cases.

## Preconditions

The real `login` function and real bcrypt comparisons are used. Prisma is mocked at the data-access boundary. `tokenService.generateAuthTokens` is mocked as a dependency of `login`; its token implementation is not a separate unit under test. No live database connection is used.

All found accounts use the following base fixture. The account role, status, and stored password hash are selected by the precondition rows in the matrix.

```javascript
const ACCOUNT_ID = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa";
const OWNER_ID = "22222222-2222-4222-8222-222222222222";
const EMAIL = "login@example.com";

const account = {
  id: ACCOUNT_ID,
  email: EMAIL,
  phone: null,
  passwordHash: STORED_HASH,
  fullName: "Login Test",
  avatarUrl: null,
  role: ROLE,
  status: STATUS,
  managedByOwnerId: ["TECHNICIAN", "EXPERT"].includes(ROLE) ? OWNER_ID : null,
  activatedAt: new Date("2026-01-01T00:00:00Z"),
  lastLoginAt: null,
  createdAt: new Date("2026-01-01T00:00:00Z"),
  updatedAt: new Date("2026-01-02T00:00:00Z"),
};
```

For the pending-activation fixture, `passwordHash`, `fullName`, and `activatedAt` are all `null`. This fixture reaches the invalid-credentials rejection before any account-status error is evaluated.

For successful authentication and the token-dependency failure case, the account re-read returns the same account and the account update resolves to `{ count: 1 }`.

Dependency fixtures:

```javascript
const TOKENS = {
  "accessToken": "fixture-access-token",
  "refreshToken": "fixture-refresh-token"
};
const LOOKUP_ERROR = new Error("Account lookup failed");
const TOKEN_ERROR = new Error("Token generation failed");
const GENERATED_DEVICE_ID = "33333333-3333-4333-8333-333333333333";
```

`generateAuthTokens` resolves to `TOKENS` in successful cases. For UTCID18, it rejects with the same `TOKEN_ERROR` instance. For UTCID17, the initial account lookup rejects with the same `LOOKUP_ERROR` instance. UUID generation is controlled to return `GENERATED_DEVICE_ID` when the third argument is `undefined`.

## Expected return value

In successful cases, the promise resolves to the following complete object. `ROLE` is the account role selected in Preconditions. `T` is the `Date` created by `login` and written to `lastLoginAt`; the test asserts that the returned value uses that same timestamp. `TOKENS` is the exact dependency-provided object defined above.

```javascript
{
  account: {
    id: ACCOUNT_ID,
    email: EMAIL,
    phone: null,
    fullName: "Login Test",
    avatarUrl: null,
    role: ROLE,
    status: "ACTIVE",
    managedByOwnerId: ["TECHNICIAN", "EXPERT"].includes(ROLE) ? OWNER_ID : null,
    activatedAt: new Date("2026-01-01T00:00:00Z"),
    lastLoginAt: T,
    createdAt: new Date("2026-01-01T00:00:00Z"),
    updatedAt: new Date("2026-01-02T00:00:00Z"),
  },
  tokens: TOKENS,
}
```

`passwordHash` is absent from the returned account.

## Condition / Confirm / Result

### UTCID01-UTCID09

| Section | Item | Condition / expected result | UTCID01 | UTCID02 | UTCID03 | UTCID04 | UTCID05 | UTCID06 | UTCID07 | UTCID08 | UTCID09 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Condition | Precondition |  |  |  |  |  |  |  |  |  |  |
|  |  | Real login function; mocked Prisma delegates; real bcrypt comparisons. | O | O | O | O | O | O | O | O | O |
|  |  | Initial account lookup resolves to an account. | O | O | O | O | O | O |  | O | O |
|  |  | Initial account lookup resolves to null. |  |  |  |  |  |  | O |  |  |
|  |  | Stored account role = `ADMIN`. | O |  |  |  |  |  |  |  |  |
|  |  | Stored account role = `FARM_OWNER`. |  | O |  |  | O | O |  | O | O |
|  |  | Stored account role = `TECHNICIAN`. |  |  | O |  |  |  |  |  |  |
|  |  | Stored account role = `EXPERT`. |  |  |  | O |  |  |  |  |  |
|  |  | Stored account status = `ACTIVE`. | O | O | O | O | O | O |  | O |  |
|  |  | Stored account status = `PENDING_ACTIVATION`. |  |  |  |  |  |  |  |  | O |
|  |  | Stored passwordHash is a real bcrypt hash of `"Login123!"`. | O | O | O | O | O | O |  | O |  |
|  |  | Stored passwordHash, fullName, and activatedAt are null. |  |  |  |  |  |  |  |  | O |
|  |  | Account re-read returns the same account; update resolves to { count: 1 }. | O | O | O | O | O |  |  |  |  |
|  |  | generateAuthTokens resolves to TOKENS. | O | O | O | O | O |  |  |  |  |
|  | Test data: email |  |  |  |  |  |  |  |  |  |  |
|  |  | `"login@example.com"` | O | O | O | O | O | O | O | O | O |
|  | Test data: password |  |  |  |  |  |  |  |  |  |  |
|  |  | `"Login123!"` | O | O | O | O | O |  | O |  | O |
|  |  | `""` |  |  |  |  |  | O |  |  |  |
|  |  | `"Wrong123!"` |  |  |  |  |  |  |  | O |  |
|  | Test data: deviceId |  |  |  |  |  |  |  |  |  |  |
|  |  | `"11111111-1111-4111-8111-111111111111"` | O | O | O | O |  | O | O | O | O |
|  |  | `undefined` |  |  |  |  | O |  |  |  |  |
| Confirm | Return |  |  |  |  |  |  |  |  |  |  |
|  |  | Resolve the exact { account, tokens } object defined in Expected return value. | O | O | O | O | O |  |  |  |  |
|  | Exception |  |  |  |  |  |  |  |  |  |  |
|  |  | Reject ApiError: statusCode = 401; message = messages.AUTH.INVALID_CREDENTIALS; no errorCode property. |  |  |  |  |  | O | O | O | O |
| Result | Type (N / A / B) |  | N | N | N | N | N | B | A | A | A |
|  | Passed/Failed |  | P | P | P | P | P | P | P | P | P |
|  | Executed Date |  | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 |
|  | Defect ID |  | - | - | - | - | - | - | - | - | - |

### UTCID10-UTCID18

| Section | Item | Condition / expected result | UTCID10 | UTCID11 | UTCID12 | UTCID13 | UTCID14 | UTCID15 | UTCID16 | UTCID17 | UTCID18 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Condition | Precondition |  |  |  |  |  |  |  |  |  |  |
|  |  | Real login function; mocked Prisma delegates; real bcrypt comparisons. | O | O | O | O | O | O | O | O | O |
|  |  | Initial account lookup resolves to an account. | O | O | O | O | O | O | O |  | O |
|  |  | Initial account lookup rejects with LOOKUP_ERROR. |  |  |  |  |  |  |  | O |  |
|  |  | Stored account role = `FARM_OWNER`. | O | O | O | O | O | O | O |  | O |
|  |  | Stored account status = `ACTIVE`. |  |  |  |  | O | O | O |  | O |
|  |  | Stored account status = `BLOCKED`. | O |  | O |  |  |  |  |  |  |
|  |  | Stored account status = `INACTIVE`. |  | O |  | O |  |  |  |  |  |
|  |  | Stored passwordHash is a real bcrypt hash of `"Login123!"`. | O | O | O | O | O | O |  |  | O |
|  |  | Stored passwordHash is a real bcrypt hash of `" Login123! "`. |  |  |  |  |  |  | O |  |  |
|  |  | Account re-read returns the same account; update resolves to { count: 1 }. |  |  |  |  |  |  | O |  | O |
|  |  | generateAuthTokens resolves to TOKENS. |  |  |  |  |  |  | O |  |  |
|  |  | generateAuthTokens rejects with TOKEN_ERROR. |  |  |  |  |  |  |  |  | O |
|  | Test data: email |  |  |  |  |  |  |  |  |  |  |
|  |  | `"login@example.com"` | O | O | O | O | O | O | O | O | O |
|  | Test data: password |  |  |  |  |  |  |  |  |  |  |
|  |  | `"Login123!"` | O | O |  |  |  |  |  | O | O |
|  |  | `"Wrong123!"` |  |  | O | O |  |  |  |  |  |
|  |  | `"login123!"` |  |  |  |  | O |  |  |  |  |
|  |  | `" Login123! "` |  |  |  |  |  | O | O |  |  |
|  | Test data: deviceId |  |  |  |  |  |  |  |  |  |  |
|  |  | `"11111111-1111-4111-8111-111111111111"` | O | O | O | O | O | O | O | O | O |
| Confirm | Return |  |  |  |  |  |  |  |  |  |  |
|  |  | Resolve the exact { account, tokens } object defined in Expected return value. |  |  |  |  |  |  | O |  |  |
|  | Exception |  |  |  |  |  |  |  |  |  |  |
|  |  | Reject ApiError: statusCode = 401; message = messages.AUTH.INVALID_CREDENTIALS; no errorCode property. |  |  | O | O | O | O |  |  |  |
|  |  | Reject ApiError: statusCode = 403; message = messages.AUTH.ACCOUNT_BLOCKED; errorCode = AUTH_ACCOUNT_BLOCKED. | O |  |  |  |  |  |  |  |  |
|  |  | Reject ApiError: statusCode = 403; message = messages.AUTH.ACCOUNT_INACTIVE; errorCode = AUTH_ACCOUNT_INACTIVE. |  | O |  |  |  |  |  |  |  |
|  |  | Reject with the original LOOKUP_ERROR instance: Error("Account lookup failed"). |  |  |  |  |  |  |  | O |  |
|  |  | Reject with the original TOKEN_ERROR instance: Error("Token generation failed"). |  |  |  |  |  |  |  |  | O |
| Result | Type (N / A / B) |  | A | A | A | A | A | A | N | A | A |
|  | Passed/Failed |  | P | P | P | P | P | P | P | P | P |
|  | Executed Date |  | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 | 2026-11-09 |
|  | Defect ID |  | - | - | - | - | - | - | - | - | - |

## Case register

All three function parameters are specified for every case, including the explicit `undefined` value in UTCID05.

| Case | Scenario | email | password | deviceId |
| --- | --- | --- | --- | --- |
| UTCID01 | Active Admin with matching credentials | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID02 | Active Farm Owner with matching credentials | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID03 | Active Technician with matching credentials | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID04 | Active Expert with matching credentials | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID05 | Undefined deviceId uses a generated UUID | `"login@example.com"` | `"Login123!"` | `undefined` |
| UTCID06 | Empty password does not match the stored password | `"login@example.com"` | `""` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID07 | Account does not exist | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID08 | Incorrect password | `"login@example.com"` | `"Wrong123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID09 | Pending account has no stored password hash | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID10 | Blocked account with matching password | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID11 | Inactive account with matching password | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID12 | Blocked account with incorrect password | `"login@example.com"` | `"Wrong123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID13 | Inactive account with incorrect password | `"login@example.com"` | `"Wrong123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID14 | Password case differs from the stored password | `"login@example.com"` | `"login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID15 | Extra password spaces do not match the stored password | `"login@example.com"` | `" Login123! "` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID16 | Matching password containing spaces is preserved | `"login@example.com"` | `" Login123! "` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID17 | Account lookup rejects | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |
| UTCID18 | Token generation dependency rejects | `"login@example.com"` | `"Login123!"` | `"11111111-1111-4111-8111-111111111111"` |

UTCID06 is the zero-character boundary case for the password argument against a non-empty stored secret. It verifies the credential mismatch; it does not assert a password-creation length rule.

## Execution evidence

Executed at 2026-11-09 22:48:46 (Asia/Saigon). Only `tests/login.service.test.js` was selected. Result: **18 passed, 0 failed, 0 skipped; 1 suite**.

The tests assert the complete resolved object, passwordHash removal, exact exception type and fields or dependency-error identity, and the account/token dependency calls made by login. No runtime token-format or token-storage tests are included in these counts.

```powershell
node node_modules/jest/bin/jest.js --runInBand --runTestsByPath tests/login.service.test.js --json --outputFile=../.tmp/report5-login-service-20261109/results.json
```

Source: `src/services/auth.service.js`, lines 39-83. LOC counts nonblank, non-comment lines in this function. The template's density formula is preserved: `LOC * 100 / 1000 - Total Test Cases` = 40 * 100 / 1000 - 18 = -14. A negative value indicates cases above the inherited 100-cases/KLOC norm; it is not a branch-coverage measure.

Defect ID is "-" because all listed cases matched their expected results. Execution results are recorded in `.tmp/report5-login-service-20261109/results.json`.
