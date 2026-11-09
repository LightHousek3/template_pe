# Report 5 - Logout Service Unit Test

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-02 | Function Name | `authService.logout(refreshToken)` |
| Created By | Pham Hai Dang | Executed By | Codex / Jest (automated) |
| Lines of code | 5 | Lack of test cases | Not calculated (KLOC norm not specified) |
| Test requirement | Delegate supplied refresh tokens for revocation, allow repeated or missing-token logout, and resolve to undefined. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 6 | 0 | 0 | 3 | 3 | 0 | 6 |

| Section | Item | UTCID01 | UTCID02 | UTCID03 | UTCID04 | UTCID05 | UTCID06 |
| --- | --- | --- | --- | --- | --- | --- | --- |
|  | Scenario | Supplied refresh token | Repeated logout with the same token | Refresh token omitted | Empty refresh token | Null refresh token | Unrecognized token string is forwarded unchanged |
| Condition | **Precondition** |  |  |  |  |  |  |
|  | Can connect with server | O | O | O | O | O | O |
|  | Token service is available and completes refresh token revocation successfully | O | O | O | O | O | O |
|  | **Refresh token** |  |  |  |  |  |  |
|  | `refreshToken_provided = "refresh-token-01"` | O | O |  |  |  |  |
|  | `refreshToken_omitted = undefined` |  |  | O |  |  |  |
|  | `refreshToken_empty = ""` |  |  |  | O |  |  |
|  | `refreshToken_null = null` |  |  |  |  | O |  |
|  | `refreshToken_unrecognized = "not-a-refresh-token"` |  |  |  |  |  | O |
| Confirm | **Return**: `undefined` | O | O | O | O | O | O |
|  | **Exception**: None | O | O | O | O | O | O |
|  | Token service is called once with the supplied refreshToken | O |  |  |  |  | O |
|  | Token service is called once per logout invocation (twice total) |  | O |  |  |  |  |
|  | Token service is not called |  |  | O | O | O |  |
|  | Logout waits for token revocation to complete | O | O |  |  |  | O |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) | N | N | N | A | A | A |
|  | Passed/Failed | P | P | P | P | P | P |
|  | Executed Date | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 | 2026-11-10 |
|  | Defect ID |  |  |  |  |  |  |
