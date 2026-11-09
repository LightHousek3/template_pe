# Report 5 — Unit Test: Login

Tài liệu dùng cấu trúc ma trận của mẫu: **mỗi cột là một test case; mỗi dòng là một điều kiện hoặc một kết quả cần xác nhận; đánh dấu `O` tại các giao điểm áp dụng**. Các nhóm giữ nguyên thứ tự **Condition → Confirm → Result**.

Các dòng Date / Month / Year trong ảnh là dữ liệu minh họa cho một hàm kiểm tra ngày. Với Login, chúng được thay bằng Email / Password / deviceId và trạng thái Account. Login có các unit với hợp đồng khác nhau, nên phần dưới trình bày riêng service, validation và controller.

`O` = điều kiện được thiết lập hoặc kết quả được assertion kiểm tra. Ô trống = dòng không áp dụng cho case đó. `N/A` = nội dung không được kiểm tra tại unit này. `P` = quan sát đúng kỳ vọng, bao gồm cả các case phải bị từ chối. `N` = Normal; `A` = Abnormal; `B` = Boundary.

**Return** dùng kết quả thật của unit. Service trả `{account, tokens}`; validation chuyển tiếp bằng `next()` hoặc `next(error)`; controller tạo response bằng `res`. **Exception** ghi loại lỗi, `statusCode` và `error.message`. **Log message** dành cho log được kiểm tra; bộ unit test này không assert logger nên ghi `N/A`, không dùng thông báo response làm log.

Phạm vi: luồng Login chính. Theo yêu cầu, không đưa các case thay đổi mật khẩu/trạng thái trong lúc đăng nhập, xung đột transaction hoặc giới hạn byte của bcrypt vào tài liệu. Không thay đổi logic BE.

## 1. Login — service nghiệp vụ

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-01 | Function Name | `authService.login(email, password, deviceId)` |
| Created By | Pham Hai Dang | Executed By | Codex / Jest — chạy tự động |
| Lines of code | 40 | Lack of test cases | -14 |
| Test requirement | Xác thực email/mật khẩu; chỉ chấp nhận account ACTIVE; trả dữ liệu account công khai và token; cập nhật thông tin phiên; từ chối đúng lỗi khi xác thực hoặc phụ thuộc thất bại. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 18 | 0 | 0 | 6 | 11 | 1 | 18 |

Nguồn unit: `src/services/auth.service.js`:39–83. LOC đếm dòng không trống, không tính dòng comment trong hàm được ghi ở Function Name.

Các điều kiện Email/Password ở đây là dữ liệu gọi service sau bước kiểm tra request. Service unit không tự chuẩn hóa email hoặc trả HTTP response. Account PENDING_ACTIVATION được thiết lập đúng trạng thái chưa kích hoạt: không có password hash, fullName và activatedAt đều null; kết quả hiện tại là lỗi thông tin đăng nhập 401.

### Condition / Confirm / Result — UTCID01–UTCID09

| Section | Item | Condition / expected result | UTCID01 | UTCID02 | UTCID03 | UTCID04 | UTCID05 | UTCID06 | UTCID07 | UTCID08 | UTCID09 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Condition | Precondition |  |  |  |  |  |  |  |  |  |  |
|  |  | Hàm thật được nạp; Prisma được mock tại biên dữ liệu. | O | O | O | O | O | O | O | O | O |
|  | Account lookup |  |  |  |  |  |  |  |  |  |  |
|  |  | Tìm thấy account. | O | O | O | O | O | O |  | O | O |
|  |  | Không tìm thấy account. |  |  |  |  |  |  | O |  |  |
|  | Account role |  |  |  |  |  |  |  |  |  |  |
|  |  | `ADMIN` | O |  |  |  |  |  |  |  |  |
|  |  | `FARM_OWNER` |  | O |  |  | O | O |  | O | O |
|  |  | `TECHNICIAN` |  |  | O |  |  |  |  |  |  |
|  |  | `EXPERT` |  |  |  | O |  |  |  |  |  |
|  | Account status |  |  |  |  |  |  |  |  |  |  |
|  |  | `ACTIVE` | O | O | O | O | O | O |  | O |  |
|  |  | `PENDING_ACTIVATION` |  |  |  |  |  |  |  |  | O |
|  | Stored password |  |  |  |  |  |  |  |  |  |  |
|  |  | Hash bcrypt thật của `"Login123!"`. | O | O | O | O | O |  |  | O |  |
|  |  | Hash bcrypt thật của `"x"`. |  |  |  |  |  | O |  |  |  |
|  |  | passwordHash = null; fullName = null; activatedAt = null. |  |  |  |  |  |  |  |  | O |
|  | Dependency behavior |  |  |  |  |  |  |  |  |  |  |
|  |  | Các lệnh ghi phiên thành công khi được gọi. | O | O | O | O | O | O |  |  |  |
|  | Email |  |  |  |  |  |  |  |  |  |  |
|  |  | `login@example.com` | O | O | O | O | O | O | O | O | O |
|  | Password |  |  |  |  |  |  |  |  |  |  |
|  |  | `"Login123!"` | O | O | O | O | O |  | O |  | O |
|  |  | `"x"` |  |  |  |  |  | O |  |  |  |
|  |  | `"Wrong123!"` |  |  |  |  |  |  |  | O |  |
|  | deviceId |  |  |  |  |  |  |  |  |  |  |
|  |  | `11111111-1111-4111-8111-111111111111` | O | O | O | O |  | O | O | O | O |
|  |  | Không truyền deviceId. |  |  |  |  | O |  |  |  |  |
| Confirm | Return |  |  |  |  |  |  |  |  |  |  |
|  |  | Resolve {account, tokens}; account đúng dữ liệu và không có passwordHash. | O | O | O | O | O | O |  |  |  |
|  |  | Access JWT có chữ ký hợp lệ, đúng sub / role / type và exp > iat. | O | O | O | O | O | O |  |  |  |
|  |  | Refresh JWT có chữ ký hợp lệ, đúng sub / type / deviceId, có jti và exp > iat. | O | O | O | O | O | O |  |  |  |
|  |  | Dùng đúng deviceId được truyền vào. | O | O | O | O |  | O |  |  |  |
|  |  | Sinh UUID v4 khi không truyền deviceId. |  |  |  |  | O |  |  |  |  |
|  |  | Cập nhật lastLoginAt; account trả về chứa đúng thời điểm cập nhật. | O | O | O | O | O | O |  |  |  |
|  |  | Ghi SHA-256 refresh-token hash, đúng accountId / deviceId / expiresAt bằng transaction client được cấp. | O | O | O | O | O | O |  |  |  |
|  | Exception |  |  |  |  |  |  |  |  |  |  |
|  |  | Reject ApiError; statusCode = 401; message = `Email hoặc mật khẩu không chính xác`. |  |  |  |  |  |  | O | O | O |
|  |  | Xác thực bị từ chối: không gọi transaction, không cập nhật lastLoginAt và không ghi refresh token. |  |  |  |  |  |  | O | O | O |
|  | Log message |  |  |  |  |  |  |  |  |  |  |
|  |  | Không assert logger trong các unit case này. | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) |  | N | N | N | N | N | B | A | A | A |
|  | Passed/Failed |  | P | P | P | P | P | P | P | P | P |
|  | Executed Date |  | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 |
|  | Defect ID |  | — | — | — | — | — | — | — | — | — |

### Condition / Confirm / Result — UTCID10–UTCID18

| Section | Item | Condition / expected result | UTCID10 | UTCID11 | UTCID12 | UTCID13 | UTCID14 | UTCID15 | UTCID16 | UTCID17 | UTCID18 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Condition | Precondition |  |  |  |  |  |  |  |  |  |  |
|  |  | Hàm thật được nạp; Prisma được mock tại biên dữ liệu. | O | O | O | O | O | O | O | O | O |
|  | Account lookup |  |  |  |  |  |  |  |  |  |  |
|  |  | Tìm thấy account. | O | O | O | O | O | O | O |  | O |
|  |  | Mock account.findUnique reject Error đã định trước. |  |  |  |  |  |  |  | O |  |
|  | Account role |  |  |  |  |  |  |  |  |  |  |
|  |  | `FARM_OWNER` | O | O | O | O | O | O | O |  | O |
|  | Account status |  |  |  |  |  |  |  |  |  |  |
|  |  | `ACTIVE` |  |  |  |  | O | O | O |  | O |
|  |  | `BLOCKED` | O |  | O |  |  |  |  |  |  |
|  |  | `INACTIVE` |  | O |  | O |  |  |  |  |  |
|  | Stored password |  |  |  |  |  |  |  |  |  |  |
|  |  | Hash bcrypt thật của `"Login123!"`. | O | O | O | O | O | O |  |  | O |
|  |  | Hash bcrypt thật của `" Login123! "`. |  |  |  |  |  |  | O |  |  |
|  | Dependency behavior |  |  |  |  |  |  |  |  |  |  |
|  |  | Các lệnh ghi phiên thành công khi được gọi. |  |  |  |  |  |  | O |  |  |
|  |  | Mock refreshToken.create reject Error đã định trước. |  |  |  |  |  |  |  |  | O |
|  | Email |  |  |  |  |  |  |  |  |  |  |
|  |  | `login@example.com` | O | O | O | O | O | O | O | O | O |
|  | Password |  |  |  |  |  |  |  |  |  |  |
|  |  | `"Login123!"` | O | O |  |  |  |  |  | O | O |
|  |  | `"Wrong123!"` |  |  | O | O |  |  |  |  |  |
|  |  | `"login123!"` |  |  |  |  | O |  |  |  |  |
|  |  | `" Login123! "` |  |  |  |  |  | O | O |  |  |
|  | deviceId |  |  |  |  |  |  |  |  |  |  |
|  |  | `11111111-1111-4111-8111-111111111111` | O | O | O | O | O | O | O | O | O |
| Confirm | Return |  |  |  |  |  |  |  |  |  |  |
|  |  | Resolve {account, tokens}; account đúng dữ liệu và không có passwordHash. |  |  |  |  |  |  | O |  |  |
|  |  | Access JWT có chữ ký hợp lệ, đúng sub / role / type và exp > iat. |  |  |  |  |  |  | O |  |  |
|  |  | Refresh JWT có chữ ký hợp lệ, đúng sub / type / deviceId, có jti và exp > iat. |  |  |  |  |  |  | O |  |  |
|  |  | Dùng đúng deviceId được truyền vào. |  |  |  |  |  |  | O |  |  |
|  |  | Cập nhật lastLoginAt; account trả về chứa đúng thời điểm cập nhật. |  |  |  |  |  |  | O |  |  |
|  |  | Ghi SHA-256 refresh-token hash, đúng accountId / deviceId / expiresAt bằng transaction client được cấp. |  |  |  |  |  |  | O |  |  |
|  | Exception |  |  |  |  |  |  |  |  |  |  |
|  |  | Reject ApiError; statusCode = 401; message = `Email hoặc mật khẩu không chính xác`. |  |  | O | O | O | O |  |  |  |
|  |  | Reject ApiError; statusCode = 403; errorCode = AUTH_ACCOUNT_BLOCKED; message = `Tài khoản của bạn đã bị khóa. Vui lòng liên hệ bộ phận hỗ trợ`. | O |  |  |  |  |  |  |  |  |
|  |  | Reject ApiError; statusCode = 403; errorCode = AUTH_ACCOUNT_INACTIVE; message = `Tài khoản đang tạm ngừng sử dụng. Vui lòng liên hệ bộ phận hỗ trợ`. |  | O |  |  |  |  |  |  |  |
|  |  | Xác thực bị từ chối: không gọi transaction, không cập nhật lastLoginAt và không ghi refresh token. | O | O | O | O | O | O |  |  |  |
|  |  | Lỗi tra cứu: propagate cùng Error; không gọi transaction hoặc refreshToken.create. |  |  |  |  |  |  |  | O |  |
|  |  | Lỗi ghi token: propagate cùng Error; refreshToken.create được gọi đúng một lần. |  |  |  |  |  |  |  |  | O |
|  |  | Error.message = `Controlled login dependency failure`. |  |  |  |  |  |  |  | O | O |
|  | Log message |  |  |  |  |  |  |  |  |  |  |
|  |  | Không assert logger trong các unit case này. | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) |  | A | A | A | A | A | A | N | A | A |
|  | Passed/Failed |  | P | P | P | P | P | P | P | P | P |
|  | Executed Date |  | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 |
|  | Defect ID |  | — | — | — | — | — | — | — | — | — |

Case B với mật khẩu `x` xác nhận biên dưới mà Login hiện chấp nhận cho một mật khẩu đã có hash. Quy tắc tạo/đặt lại mật khẩu nằm ngoài unit này. Case lỗi ghi token chỉ xác nhận propagate lỗi; mock không chứng minh database rollback.

## 2. Login — kiểm tra dữ liệu đầu vào

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-01-V | Function Name | `validate(authValidator.login)` |
| Created By | Pham Hai Dang | Executed By | Codex / Jest — chạy tự động |
| Lines of code | 15 | Lack of test cases | -26.5 |
| Test requirement | Kiểm tra các trường email, password, deviceId và trường không được khai báo; chuẩn hóa email; giữ nguyên password; gọi next() khi hợp lệ hoặc next(ApiError) khi không hợp lệ. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 28 | 0 | 0 | 4 | 20 | 4 | 28 |

Nguồn unit: `src/middlewares/validate.middleware.js`:15–33. LOC đếm dòng không trống, không tính dòng comment trong hàm được ghi ở Function Name.

Schema dùng trong unit: `src/validators/auth.validator.js`, đối tượng `login`. LOC ở đầu bảng chỉ tính hàm middleware `validate`; schema và hàm tạo trường dữ liệu là cấu hình/phụ thuộc. Unit này không tra cứu Account, không so mật khẩu với database và không tạo phiên.

### Condition / Confirm / Result — UTCID19–UTCID28

| Section | Item | Condition / expected result | UTCID19 | UTCID20 | UTCID21 | UTCID22 | UTCID23 | UTCID24 | UTCID25 | UTCID26 | UTCID27 | UTCID28 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Condition | Precondition |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Schema Joi và middleware thật; next là spy; không dùng database. | O | O | O | O | O | O | O | O | O | O |
|  | email |  |  |  |  |  |  |  |  |  |  |  |
|  |  | `"login@example.com"` | O |  | O |  |  |  |  |  |  |  |
|  |  | `"  LOGIN@EXAMPLE.COM  "` |  | O |  |  |  |  |  |  |  |  |
|  |  | Không truyền trường này. |  |  |  | O |  |  |  |  |  |  |
|  |  | `""` |  |  |  |  | O |  |  |  |  |  |
|  |  | `"   "` |  |  |  |  |  | O |  |  |  |  |
|  |  | `null` |  |  |  |  |  |  | O |  |  |  |
|  |  | `123` |  |  |  |  |  |  |  | O |  |  |
|  |  | `{}` |  |  |  |  |  |  |  |  | O |  |
|  |  | `["login@example.com"]` |  |  |  |  |  |  |  |  |  | O |
|  | password |  |  |  |  |  |  |  |  |  |  |  |
|  |  | `"Login123!"` | O | O | O | O | O | O | O | O | O | O |
|  | deviceId |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Không truyền trường này. | O | O |  | O | O | O | O | O | O | O |
|  |  | `"11111111-1111-4111-8111-111111111111"` |  |  | O |  |  |  |  |  |  |  |
|  | Other body fields |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Không có role hoặc accountId do client truyền thêm. | O | O | O | O | O | O | O | O | O | O |
| Confirm | Return |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Schema không có lỗi; middleware gọi next() đúng một lần, không truyền lỗi. | O | O | O |  |  |  |  |  |  |  |
|  |  | req.body.email = login@example.com sau trim / lowercase. | O | O | O |  |  |  |  |  |  |  |
|  |  | req.body.password và deviceId giữ đúng giá trị được truyền vào. | O | O | O |  |  |  |  |  |  |  |
|  | Exception |  |  |  |  |  |  |  |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"email" is required`. |  |  |  | O |  |  |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"email" is not allowed to be empty`. |  |  |  |  | O | O |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"email" must be a string`. |  |  |  |  |  |  | O | O | O | O |
|  |  | Joi error: `email / any.required`. |  |  |  | O |  |  |  |  |  |  |
|  |  | Joi error: `email / string.empty`. |  |  |  |  | O | O |  |  |  |  |
|  |  | Joi error: `email / string.base`. |  |  |  |  |  |  | O | O | O | O |
|  | Log message |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Không assert logger trong các unit case này. | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) |  | N | N | N | A | B | B | A | A | A | A |
|  | Passed/Failed |  | P | P | P | P | P | P | P | P | P | P |
|  | Executed Date |  | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 |
|  | Defect ID |  | — | — | — | — | — | — | — | — | — | — |

### Condition / Confirm / Result — UTCID29–UTCID38

| Section | Item | Condition / expected result | UTCID29 | UTCID30 | UTCID31 | UTCID32 | UTCID33 | UTCID34 | UTCID35 | UTCID36 | UTCID37 | UTCID38 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Condition | Precondition |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Schema Joi và middleware thật; next là spy; không dùng database. | O | O | O | O | O | O | O | O | O | O |
|  | email |  |  |  |  |  |  |  |  |  |  |  |
|  |  | `"login.example.com"` | O |  |  |  |  |  |  |  |  |  |
|  |  | `"login@"` |  | O |  |  |  |  |  |  |  |  |
|  |  | `"login@example.com"` |  |  | O | O | O | O | O | O | O | O |
|  | password |  |  |  |  |  |  |  |  |  |  |  |
|  |  | `"Login123!"` | O | O |  |  |  |  |  |  |  |  |
|  |  | Không truyền trường này. |  |  | O |  |  |  |  |  |  |  |
|  |  | `""` |  |  |  | O |  |  |  |  |  |  |
|  |  | `null` |  |  |  |  | O |  |  |  |  |  |
|  |  | `123` |  |  |  |  |  | O |  |  |  |  |
|  |  | `{}` |  |  |  |  |  |  | O |  |  |  |
|  |  | `["Login123!"]` |  |  |  |  |  |  |  | O |  |  |
|  |  | `"x"` |  |  |  |  |  |  |  |  | O |  |
|  |  | `" Login123! "` |  |  |  |  |  |  |  |  |  | O |
|  | deviceId |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Không truyền trường này. | O | O | O | O | O | O | O | O | O | O |
|  | Other body fields |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Không có role hoặc accountId do client truyền thêm. | O | O | O | O | O | O | O | O | O | O |
| Confirm | Return |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Schema không có lỗi; middleware gọi next() đúng một lần, không truyền lỗi. |  |  |  |  |  |  |  |  | O | O |
|  |  | req.body.email = login@example.com sau trim / lowercase. |  |  |  |  |  |  |  |  | O | O |
|  |  | req.body.password và deviceId giữ đúng giá trị được truyền vào. |  |  |  |  |  |  |  |  | O | O |
|  | Exception |  |  |  |  |  |  |  |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"email" must be a valid email`. | O | O |  |  |  |  |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"password" is required`. |  |  | O |  |  |  |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"password" is not allowed to be empty`. |  |  |  | O |  |  |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"password" must be a string`. |  |  |  |  | O | O | O | O |  |  |
|  |  | Joi error: `email / string.email`. | O | O |  |  |  |  |  |  |  |  |
|  |  | Joi error: `password / any.required`. |  |  | O |  |  |  |  |  |  |  |
|  |  | Joi error: `password / string.empty`. |  |  |  | O |  |  |  |  |  |  |
|  |  | Joi error: `password / string.base`. |  |  |  |  | O | O | O | O |  |  |
|  | Log message |  |  |  |  |  |  |  |  |  |  |  |
|  |  | Không assert logger trong các unit case này. | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) |  | A | A | A | B | A | A | A | A | B | N |
|  | Passed/Failed |  | P | P | P | P | P | P | P | P | P | P |
|  | Executed Date |  | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 |
|  | Defect ID |  | — | — | — | — | — | — | — | — | — | — |

### Condition / Confirm / Result — UTCID39–UTCID46

| Section | Item | Condition / expected result | UTCID39 | UTCID40 | UTCID41 | UTCID42 | UTCID43 | UTCID44 | UTCID45 | UTCID46 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Condition | Precondition |  |  |  |  |  |  |  |  |  |
|  |  | Schema Joi và middleware thật; next là spy; không dùng database. | O | O | O | O | O | O | O | O |
|  | email |  |  |  |  |  |  |  |  |  |
|  |  | `"login@example.com"` | O | O | O | O | O | O | O |  |
|  |  | Không truyền trường này. |  |  |  |  |  |  |  | O |
|  | password |  |  |  |  |  |  |  |  |  |
|  |  | `"Login123!"` | O | O | O | O | O | O | O |  |
|  |  | Không truyền trường này. |  |  |  |  |  |  |  | O |
|  | deviceId |  |  |  |  |  |  |  |  |  |
|  |  | `"not-a-uuid"` | O |  |  |  |  |  |  |  |
|  |  | `null` |  | O |  |  |  |  |  |  |
|  |  | `""` |  |  | O |  |  |  |  |  |
|  |  | `123` |  |  |  | O |  |  |  |  |
|  |  | `"11111111-1111-1111-8111-111111111111"` |  |  |  |  | O |  |  |  |
|  |  | Không truyền trường này. |  |  |  |  |  | O | O | O |
|  | Other body fields |  |  |  |  |  |  |  |  |  |
|  |  | Không có role hoặc accountId do client truyền thêm. | O | O | O | O | O |  |  | O |
|  |  | role = ADMIN. |  |  |  |  |  | O |  |  |
|  |  | accountId = `11111111-1111-4111-8111-111111111111`. |  |  |  |  |  |  | O |  |
| Confirm | Return |  |  |  |  |  |  |  |  |  |
|  |  | Schema không có lỗi; middleware gọi next() đúng một lần, không truyền lỗi. |  |  |  |  |  |  |  |  |
|  | Exception |  |  |  |  |  |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"deviceId" must be a valid GUID`. | O |  |  |  | O |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"deviceId" must be a string`. |  | O |  | O |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"deviceId" is not allowed to be empty`. |  |  | O |  |  |  |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"role" is not allowed`. |  |  |  |  |  | O |  |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"accountId" is not allowed`. |  |  |  |  |  |  | O |  |
|  |  | next(ApiError) đúng một lần; statusCode = 400; message = `"email" is required, "password" is required`. |  |  |  |  |  |  |  | O |
|  |  | Joi error: `email / any.required`. |  |  |  |  |  |  |  | O |
|  |  | Joi error: `password / any.required`. |  |  |  |  |  |  |  | O |
|  |  | Joi error: `deviceId / string.guid`. | O |  |  |  | O |  |  |  |
|  |  | Joi error: `deviceId / string.base`. |  | O |  | O |  |  |  |  |
|  |  | Joi error: `deviceId / string.empty`. |  |  | O |  |  |  |  |  |
|  |  | Joi error: `role / object.unknown`. |  |  |  |  |  | O |  |  |
|  |  | Joi error: `accountId / object.unknown`. |  |  |  |  |  |  | O |  |
|  | Log message |  |  |  |  |  |  |  |  |  |
|  |  | Không assert logger trong các unit case này. | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) |  | A | A | A | A | A | A | A | A |
|  | Passed/Failed |  | P | P | P | P | P | P | P | P |
|  | Executed Date |  | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 |
|  | Defect ID |  | — | — | — | — | — | — | — | — |

## 3. Login — controller trả response

| Field | Value | Field | Value |
| --- | --- | --- | --- |
| Function Code | UT-01-C | Function Name | `authController.login(req, res, next)` |
| Created By | Pham Hai Dang | Executed By | Codex / Jest — chạy tự động |
| Lines of code | 15 | Lack of test cases | -2.5 |
| Test requirement | Chuyển đúng email/password/deviceId đến authService; tạo response thành công và refresh cookie; chuyển nguyên lỗi cho next khi service reject. |  |  |

| Passed | Failed | Untested | N | A | B | Total Test Cases |
| --- | --- | --- | --- | --- | --- | --- |
| 4 | 0 | 0 | 2 | 2 | 0 | 4 |

Nguồn unit: `src/controllers/auth.controller.js`:14–30. LOC đếm dòng không trống, không tính dòng comment trong hàm được ghi ở Function Name.

authService được mock ở biên controller. Controller, asyncHandler, ResponseHandler và helper cookie chạy thật; res/next là spy. Account và token trả về từ mock là dữ liệu fixture, không đại diện cho một lần đăng nhập database.

### Condition / Confirm / Result — UTCID47–UTCID50

| Section | Item | Condition / expected result | UTCID47 | UTCID48 | UTCID49 | UTCID50 |
| --- | --- | --- | --- | --- | --- | --- |
| Condition | Precondition |  |  |  |  |  |
|  |  | Controller và các helper thật; authService / res / next được cô lập bằng mock/spy. | O | O | O | O |
|  | Service behavior |  |  |  |  |  |
|  |  | Resolve public account và accessToken / refreshToken. | O | O |  |  |
|  |  | Reject ApiError(401, "Email hoặc mật khẩu không chính xác"). |  |  | O |  |
|  |  | Reject Error("Controlled service failure"). |  |  |  | O |
|  | Email |  |  |  |  |  |
|  |  | `login@example.com` | O | O | O | O |
|  | Password |  |  |  |  |  |
|  |  | `Login123!` | O | O | O | O |
|  | deviceId |  |  |  |  |  |
|  |  | `11111111-1111-4111-8111-111111111111` | O | O | O | O |
|  | Cookie configuration |  |  |  |  |  |
|  |  | secure = false; sameSite = lax; path = /; maxAge theo cấu hình. | O |  | O | O |
|  |  | secure = true; sameSite = none; domain = smartshrimp.test. |  | O |  |  |
| Confirm | Return |  |  |  |  |  |
|  |  | authService.login nhận đúng ba tham số và được gọi đúng một lần. | O | O | O | O |
|  |  | res.status(200) và res.json(...) được gọi, mỗi hàm đúng một lần. | O | O |  |  |
|  |  | JSON = {success:true, message:`Đăng nhập thành công`, data:{account,tokens:{accessToken,refreshToken}}}. | O | O |  |  |
|  |  | Cookie chứa refresh token; httpOnly=true; path=/; secure/sameSite/maxAge đúng cấu hình. | O | O |  |  |
|  |  | Cookie có domain=smartshrimp.test khi cấu hình secure của case này được bật. |  | O |  |  |
|  |  | Không gọi next khi thành công. | O | O |  |  |
|  | Exception |  |  |  |  |  |
|  |  | next nhận đúng cùng đối tượng ApiError 401 một lần; không ghi cookie/status/JSON. |  |  | O |  |
|  |  | next nhận đúng cùng đối tượng Error một lần; không ghi cookie/status/JSON. |  |  |  | O |
|  | Log message |  |  |  |  |  |
|  |  | Không assert logger trong các unit case này. | N/A | N/A | N/A | N/A |
| Result | Type (N: Normal, A: Abnormal, B: Boundary) |  | N | N | A | A |
|  | Passed/Failed |  | P | P | P | P |
|  | Executed Date |  | 09/11/2026 | 09/11/2026 | 09/11/2026 | 09/11/2026 |
|  | Defect ID |  | — | — | — | — |

## Đối chiếu kết quả thực thi

| Unit | Passed | Failed | Untested | N | A | B |
| --- | --- | --- | --- | --- | --- | --- |
| authService.login | 18 | 0 | 0 | 6 | 11 | 1 |
| validate(authValidator.login) | 28 | 0 | 0 | 4 | 20 | 4 |
| authController.login | 4 | 0 | 0 | 2 | 2 | 0 |
| Tổng các unit thuộc Login | 50 | 0 | 0 | 12 | 33 | 5 |

Chạy lại lúc **18:14:28 9/11/26 (Asia/Saigon)**: **50 passed, 0 failed, 0 skipped**, hai test suite. Các số đếm trên là kết quả thực thi case; không phải tỷ lệ bao phủ toàn bộ nhánh BE. Các kiểm thử API/database đã thực hiện ở lần trước không được cộng vào số unit case trong tài liệu này.

**Lack of test cases:** giữ công thức gốc của mẫu `LOC × 100 / 1000 − Total Test Cases`, với norm `100 test cases/KLOC` lấy từ file mẫu. Số âm thể hiện số case vượt định mức theo công thức; không tự đổi thành 0. Chỉ số này không thay thế phân tích điều kiện và biên.

**Defect ID:** `—` vì các case trong lần chạy này đều đạt kỳ vọng; không sao chép các mã DFID và ngày chạy minh họa trong ảnh mẫu.

| UTCID trong tài liệu | Test ID thực thi | Case |
| --- | --- | --- |
| UTCID01 | LOGIN-S01 | ACTIVE ADMIN signs in |
| UTCID02 | LOGIN-S02 | ACTIVE FARM_OWNER signs in |
| UTCID03 | LOGIN-S03 | ACTIVE TECHNICIAN signs in |
| UTCID04 | LOGIN-S04 | ACTIVE EXPERT signs in |
| UTCID05 | LOGIN-S05 | Omitted deviceId generates UUID v4 |
| UTCID06 | LOGIN-S06 | One-character stored password can sign in |
| UTCID07 | LOGIN-S07 | Email does not exist |
| UTCID08 | LOGIN-S08 | Incorrect password |
| UTCID09 | LOGIN-S09 | Pending account has no password hash |
| UTCID10 | LOGIN-S10 | BLOCKED account with correct password |
| UTCID11 | LOGIN-S11 | INACTIVE account with correct password |
| UTCID12 | LOGIN-S12 | BLOCKED account with incorrect password stays generic |
| UTCID13 | LOGIN-S13 | INACTIVE account with incorrect password stays generic |
| UTCID14 | LOGIN-S14 | Password case differs |
| UTCID15 | LOGIN-S15 | Extra password spaces are significant |
| UTCID16 | LOGIN-S16 | Matching password containing spaces signs in |
| UTCID17 | LOGIN-S17 | Account lookup fails |
| UTCID18 | LOGIN-S18 | Refresh-token storage fails; no result returned |
| UTCID19 | LOGIN-V01 | Valid credentials; deviceId omitted |
| UTCID20 | LOGIN-V02 | Trim and lowercase email |
| UTCID21 | LOGIN-V03 | Valid UUID v4 deviceId |
| UTCID22 | LOGIN-V04 | Missing email |
| UTCID23 | LOGIN-V05 | Empty email (zero characters) |
| UTCID24 | LOGIN-V06 | Email becomes empty after trim |
| UTCID25 | LOGIN-V07 | Null email |
| UTCID26 | LOGIN-V08 | Numeric email |
| UTCID27 | LOGIN-V09 | Object email |
| UTCID28 | LOGIN-V10 | Array email |
| UTCID29 | LOGIN-V11 | Email without at sign |
| UTCID30 | LOGIN-V12 | Email without domain |
| UTCID31 | LOGIN-V13 | Missing password |
| UTCID32 | LOGIN-V14 | Empty password (zero characters) |
| UTCID33 | LOGIN-V15 | Null password |
| UTCID34 | LOGIN-V16 | Numeric password |
| UTCID35 | LOGIN-V17 | Object password |
| UTCID36 | LOGIN-V18 | Array password |
| UTCID37 | LOGIN-V19 | One-character password accepted by login validator |
| UTCID38 | LOGIN-V20 | Password case and spaces preserved |
| UTCID39 | LOGIN-V21 | Malformed deviceId |
| UTCID40 | LOGIN-V22 | Null deviceId |
| UTCID41 | LOGIN-V23 | Empty deviceId |
| UTCID42 | LOGIN-V24 | Numeric deviceId |
| UTCID43 | LOGIN-V25 | UUID v1 deviceId rejected |
| UTCID44 | LOGIN-V26 | Client-supplied role rejected |
| UTCID45 | LOGIN-V27 | Client-supplied accountId rejected |
| UTCID46 | LOGIN-V28 | Both credentials missing; collect both errors |
| UTCID47 | LOGIN-C01 | HTTP 200 payload and refresh cookie |
| UTCID48 | LOGIN-C02 | Configured secure refresh cookie |
| UTCID49 | LOGIN-C03 | Authentication error forwarded unchanged |
| UTCID50 | LOGIN-C04 | Unexpected service error forwarded unchanged |

### Lệnh chạy lại

Tại thư mục `smartshrimp_be`:

```powershell
node node_modules/jest/bin/jest.js --runInBand --runTestsByPath tests/login.main.test.js tests/login.controller.test.js --json --outputFile=../outputs/report5-login-20261109/unit-results-template.json
```

Nguồn assertion: `tests/login.main.test.js`, `tests/login.controller.test.js`; fixture/case: `tests/support/loginReportCases.cjs`. Kết quả Jest lưu trong `outputs/report5-login-20261109/unit-results-template.json`. Lint hai file test và case manifest, cùng `git diff --check`, đều đã chạy đạt.
