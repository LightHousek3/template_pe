# Report 3 §5.1 — Business Rules (Final, English + Vietnamese)

## 1. AUTH

### BR-1

**English:** Only Admin may create Farm Owner, Technician and Expert accounts. Self-registration and account creation by a Farm Owner are not allowed.

**Tiếng Việt:** Chỉ Admin được tạo tài khoản Farm Owner, KTV và Expert. Người dùng không được tự đăng ký và Farm Owner không được tự tạo tài khoản nhân sự.

### BR-2

**English:** A Technician or Expert account may be created only under an ACTIVE Farm Owner. Each Technician and Expert belongs to exactly one managing Farm Owner; Admin and Farm Owner accounts have no managing Owner.

**Tiếng Việt:** Tài khoản KTV hoặc Expert chỉ được tạo dưới quyền quản lý của Farm Owner đang ACTIVE. Mỗi KTV và Expert thuộc đúng một Farm Owner quản lý; tài khoản Admin và Farm Owner không có Owner quản lý.

### BR-3

**English:** An invited Farm Owner, Technician or Expert starts in PENDING_ACTIVATION. The account becomes ACTIVE only after its holder verifies the email and completes the required profile and password.

**Tiếng Việt:** Tài khoản Farm Owner, KTV hoặc Expert được mời bắt đầu ở trạng thái PENDING_ACTIVATION. Tài khoản chỉ chuyển sang ACTIVE sau khi người dùng xác minh email và hoàn tất thông tin cá nhân, mật khẩu bắt buộc.

### BR-4

**English:** An activation invitation contains an activation link, without an OTP. The OTP is sent separately when the account holder requests email verification.

**Tiếng Việt:** Thư mời kích hoạt chứa liên kết kích hoạt, không chứa OTP. OTP được gửi riêng khi người dùng yêu cầu xác minh email.

### BR-5

**English:** Email, role and managing Farm Owner cannot be changed after activation. Staff transfers between Owners and farm ownership transfers are outside the project scope.

**Tiếng Việt:** Email, vai trò và Farm Owner quản lý không được thay đổi sau khi kích hoạt. Chuyển nhân sự giữa các Owner và chuyển quyền sở hữu trại nằm ngoài phạm vi đồ án.

### BR-6

**English:** BLOCKED and INACTIVE accounts cannot access the system. Their existing login sessions are revoked.

**Tiếng Việt:** Tài khoản BLOCKED và INACTIVE không được truy cập hệ thống. Các phiên đăng nhập hiện có của tài khoản bị thu hồi.

### BR-7

**English:** An OTP is valid for 10 minutes and allows at most five failed verification attempts. A new OTP may be requested only after 60 seconds; successful verification authorizes the requested action once.

**Tiếng Việt:** OTP có hiệu lực trong 10 phút và cho phép tối đa năm lần xác minh sai. Người dùng chỉ được yêu cầu mã mới sau 60 giây; xác minh thành công chỉ cho phép thực hiện hành động đã yêu cầu một lần.

### BR-8

**English:** The OTP-request response must not disclose whether an account exists or reveal its status.

**Tiếng Việt:** Phản hồi yêu cầu OTP không được tiết lộ tài khoản có tồn tại hay trạng thái của tài khoản.

### BR-9

**English:** An ACTIVE Farm Owner, Technician or Expert may update their own full name, phone number and avatar.

**Tiếng Việt:** Farm Owner, KTV hoặc Expert đang ACTIVE được cập nhật họ tên, số điện thoại và ảnh đại diện của mình.

### BR-10

**English:** A new password must contain at least six characters and differ from the current password. Changing it requires the correct current password and revokes all previous login sessions; the current device may receive a new session.

**Tiếng Việt:** Mật khẩu mới phải có ít nhất sáu ký tự và khác mật khẩu hiện tại. Đổi mật khẩu cần nhập đúng mật khẩu hiện tại và thu hồi toàn bộ phiên đăng nhập cũ; thiết bị đang thao tác có thể nhận phiên mới.

### BR-11

**English:** A Technician or Expert assigned to a PLANNING or ACTIVE season must be replaced before deactivation. A Farm Owner cannot be deactivated while managing ACTIVE staff or owning a PLANNING or ACTIVE season.

**Tiếng Việt:** KTV hoặc Expert đang phụ trách vụ PLANNING hoặc ACTIVE phải được thay thế trước khi vô hiệu hóa. Farm Owner không được vô hiệu hóa khi còn nhân sự ACTIVE hoặc còn vụ PLANNING hay ACTIVE.

### BR-12

**English:** Every account-status change must retain the person making the change, the time and the reason.

**Tiếng Việt:** Mọi lần thay đổi trạng thái tài khoản phải lưu người thực hiện, thời điểm và lý do.

## 2. ADMIN

### BR-13

**English:** Admin may view aggregate system statistics but cannot perform farm operations, approve protocols, resolve disease cases, review AI predictions or retrain AI models.

**Tiếng Việt:** Admin được xem thống kê tổng hợp của hệ thống nhưng không được thực hiện nghiệp vụ trại, duyệt phác đồ, kết luận ca bệnh, đánh giá dự đoán AI hoặc huấn luyện lại mô hình AI.

### BR-14

**English:** Admin may correct a pending account's email and resend its activation invitation only while the account is PENDING_ACTIVATION.

**Tiếng Việt:** Admin chỉ được sửa email của tài khoản chờ kích hoạt và gửi lại thư mời khi tài khoản còn ở trạng thái PENDING_ACTIVATION.

## 3. FARM

### BR-15

**English:** Each farm belongs to one Farm Owner and has one logical inventory. Products and stock balances are managed separately for each farm.

**Tiếng Việt:** Mỗi trại thuộc một Farm Owner và có một kho logic. Vật tư và số lượng tồn kho được quản lý riêng cho từng trại.

### BR-16

**English:** A Farm Owner may manage only their own farms and the ponds, seasons and inventory belonging to those farms.

**Tiếng Việt:** Farm Owner chỉ được quản lý trại của mình cùng các ao, vụ nuôi và kho thuộc những trại đó.

### BR-17

**English:** A farm, pond, supplier, product or template with a business reference cannot be permanently deleted. Permanent deletion is allowed only when no business reference exists.

**Tiếng Việt:** Trại, ao, nhà cung cấp, vật tư hoặc mẫu phác đồ đã được nghiệp vụ khác tham chiếu không được xóa vĩnh viễn. Chỉ được xóa vĩnh viễn khi chưa có tham chiếu nghiệp vụ.

### BR-18

**English:** Pond area and depth must be positive. The declared usable water volume must be positive and must not exceed area × depth when both dimensions are known; if omitted, it is calculated from those dimensions to two decimal places.

**Tiếng Việt:** Diện tích và độ sâu ao phải dương. Thể tích nước sử dụng được khai báo phải dương và không vượt diện tích × độ sâu khi biết đủ hai kích thước; nếu bỏ trống thì tính theo hai kích thước này, làm tròn hai số thập phân.

### BR-19

**English:** A pond with a PLANNING or ACTIVE season cannot change its pond type or enter MAINTENANCE.

**Tiếng Việt:** Ao đang có vụ PLANNING hoặc ACTIVE không được đổi loại ao hoặc chuyển sang MAINTENANCE.

## 4. SEASON

### BR-20

**English:** A season may be created only in an AVAILABLE aquaculture pond of an ACTIVE farm. Each pond may have at most one PLANNING or ACTIVE season at a time.

**Tiếng Việt:** Vụ nuôi chỉ được tạo trong ao nuôi đang AVAILABLE của trại ACTIVE. Mỗi ao chỉ có tối đa một vụ PLANNING hoặc ACTIVE tại cùng thời điểm.

### BR-21

**English:** Each season starts in PLANNING. Preparing stocking data, personnel and a protocol does not activate the season.

**Tiếng Việt:** Mỗi vụ bắt đầu ở trạng thái PLANNING. Việc chuẩn bị thông tin thả giống, nhân sự và phác đồ không tự kích hoạt vụ.

### BR-22

**English:** Each season identifies one shrimp type: whiteleg shrimp or black tiger shrimp. Applied plans and water-warning ranges must match that type.

**Tiếng Việt:** Mỗi vụ xác định một loại tôm: tôm thẻ chân trắng hoặc tôm sú. Kế hoạch áp dụng và ngưỡng cảnh báo nước phải phù hợp với loại tôm đó.

### BR-23

**English:** Only the Farm Owner may activate a season. Activation requires a stocking date no later than today, a positive initial shrimp count, one assigned ACTIVE Technician, one assigned ACTIVE Expert and one APPROVED production protocol.

**Tiếng Việt:** Chỉ Farm Owner được kích hoạt vụ. Khi kích hoạt phải có ngày thả giống không sau ngày hiện tại, số giống ban đầu dương, một KTV ACTIVE, một Expert ACTIVE đang được phân công và một phác đồ nuôi APPROVED.

### BR-24

**English:** The actual stocking date is DOC 1. Culture days and operational calendar dates follow Vietnam time; protocol submission, approval and season activation do not reset DOC.

**Tiếng Việt:** Ngày thả giống thực tế là DOC 1. Ngày tuổi nuôi và ngày vận hành tính theo giờ Việt Nam; gửi, duyệt phác đồ hoặc kích hoạt vụ không đặt lại DOC.

### BR-25

**English:** Before stocking, the recorded stocking date is an estimate. At activation, the Farm Owner must confirm the actual stocking date, including any change caused by a delay before stocking.

**Tiếng Việt:** Trước khi thả giống, ngày thả được ghi là ngày dự kiến. Khi kích hoạt, Farm Owner phải xác nhận ngày thả thực tế, kể cả việc dời ngày do chậm chuẩn bị trước khi thả.

### BR-26

**English:** A season already stocked may be activated late once all activation conditions are met, with a mandatory reason. Its actual stocking date is retained, and the unrecorded period must be identified as missing data rather than zero activity.

**Tiếng Việt:** Vụ đã thả được kích hoạt muộn khi đủ điều kiện kích hoạt, kèm lý do bắt buộc. Phải giữ ngày thả thật và thể hiện khoảng chưa ghi nhận là thiếu dữ liệu, không coi là không có hoạt động.

### BR-27

**English:** Initial shrimp count and stocking density must be positive when provided. Expected and actual end dates must not precede the actual stocking date.

**Tiếng Việt:** Số tôm giống và mật độ thả ban đầu phải dương khi được cung cấp. Ngày kết thúc dự kiến và thực tế không được trước ngày thả giống thực tế.

### BR-28

**English:** Seasons begin by stocking small post-larvae, not by importing partly grown shrimp. Initial shrimp weight or biomass must not be invented as a substitute for later measurements.

**Tiếng Việt:** Vụ bắt đầu bằng thả tôm giống nhỏ, không nhập tôm đã nuôi lớn một phần. Không được tự đặt trọng lượng hoặc sinh khối giống để thay cho số đo về sau.

### BR-29

**English:** Only the Farm Owner may assign or replace season personnel. Assigned staff must be ACTIVE, have the required role and belong to that Owner; each season may have at most one current Technician and one current Expert.

**Tiếng Việt:** Chỉ Farm Owner được phân công hoặc thay thế nhân sự của vụ. Nhân sự phải ACTIVE, đúng vai trò và thuộc Owner đó; mỗi vụ chỉ có tối đa một KTV và một Expert đương nhiệm.

### BR-30

**English:** Replacement transfers the season's open Technician tasks and unresolved disease cases to the appropriate replacement. Assignment history and the authors of previous records remain unchanged.

**Tiếng Việt:** Khi thay nhân sự, các công việc KTV đang mở và ca bệnh chưa giải quyết của vụ được chuyển cho người thay thế tương ứng. Lịch sử phân công và người tạo các bản ghi trước đó được giữ nguyên.

### BR-31

**English:** Only the Farm Owner may cancel a PLANNING or ACTIVE season, with a mandatory reason. Cancellation stops new schedules and cancels all unexecuted PLANNED schedules of the season.

**Tiếng Việt:** Chỉ Farm Owner được hủy vụ PLANNING hoặc ACTIVE, kèm lý do bắt buộc. Hủy vụ sẽ dừng sinh lịch mới và hủy toàn bộ lịch PLANNED chưa thực hiện của vụ.

### BR-32

**English:** A FINAL harvest completes the season and cancels its unexecuted PLANNED schedules. A COMPLETED or CANCELLED season retains its history and accepts no new pond operations or harvests.

**Tiếng Việt:** Thu hoạch FINAL hoàn thành vụ và hủy các lịch PLANNED chưa thực hiện. Vụ COMPLETED hoặc CANCELLED giữ nguyên lịch sử và không nhận thêm hoạt động vận hành ao hoặc thu hoạch mới.

### BR-33

**English:** After a season closes, its existing tasks may still be completed or cancelled and its unresolved cases may receive a final Expert resolution. New pond operations, disease cases and treatment protocols are not allowed.

**Tiếng Việt:** Sau khi đóng vụ, các công việc cũ vẫn được hoàn tất hoặc hủy và ca chưa giải quyết vẫn được Expert kết luận để khép hồ sơ. Không được tạo vận hành ao, ca bệnh hoặc phác đồ điều trị mới.

### BR-34

**English:** Shrimp and season operations cannot be transferred between ponds or seasons. Each season remains linked to its original pond.

**Tiếng Việt:** Không được chuyển tôm hoặc nghiệp vụ của vụ giữa các ao hay các vụ. Mỗi vụ luôn gắn với ao ban đầu.

## 5. TEMPLATE

### BR-35

**English:** A production template is a reusable plan, separate from a protocol applied to a season. Editing the template does not change any protocol already created from it.

**Tiếng Việt:** Mẫu phác đồ nuôi là kế hoạch dùng lại, tách biệt với phác đồ áp dụng cho một vụ. Sửa mẫu không làm thay đổi các phác đồ đã tạo từ mẫu đó.

### BR-36

**English:** An ACTIVE Expert may manage production templates for ACTIVE farms belonging to their managing Farm Owner, without a season assignment. A template may be applied only to its own farm and a compatible shrimp type.

**Tiếng Việt:** Expert ACTIVE được quản lý mẫu phác đồ nuôi của các trại ACTIVE thuộc Farm Owner quản lý mình mà không cần phân công vụ. Mẫu chỉ được áp dụng cho chính trại đó và loại tôm phù hợp.

### BR-37

**English:** The allowed quantity variance of a production template or production protocol must be between 0% and 100%.

**Tiếng Việt:** Tỷ lệ sai lệch lượng cho phép của mẫu phác đồ nuôi hoặc phác đồ nuôi phải nằm trong khoảng 0% đến 100%.

### BR-38

**English:** A proposed product saved in a template must include complete product and compliance information. Antibiotic products cannot be included in a production template.

**Tiếng Việt:** Vật tư đề xuất được lưu trong mẫu phải có đầy đủ thông tin vật tư và hồ sơ tuân thủ. Vật tư chứa kháng sinh không được đưa vào mẫu phác đồ nuôi.

### BR-39

**English:** Only an active template may be selected for a new protocol. Deactivating a template preserves its history and does not stop protocols already created from it.

**Tiếng Việt:** Chỉ mẫu đang hoạt động được chọn để tạo phác đồ mới. Ngừng sử dụng mẫu vẫn giữ lịch sử và không làm dừng các phác đồ đã tạo từ mẫu.

## 6. PROTOCOL

### BR-40

**English:** Only the currently assigned Expert may author and submit protocols for a season. A production protocol belongs to one PLANNING or ACTIVE season; a treatment protocol belongs to one unresolved disease case of an ACTIVE season.

**Tiếng Việt:** Chỉ Expert đang được phân công được soạn và gửi phác đồ của vụ. Phác đồ nuôi thuộc một vụ PLANNING hoặc ACTIVE; phác đồ điều trị thuộc một ca bệnh chưa giải quyết của vụ ACTIVE.

### BR-41

**English:** A production protocol may be prepared and approved while the season is PLANNING. At activation or replacement, its remaining plan must cover the applicable current and future culture days; elapsed occurrences are not automatically generated, completed or added to later doses.

**Tiếng Việt:** Phác đồ nuôi được chuẩn bị và duyệt khi vụ còn PLANNING. Khi kích hoạt hoặc thay phiên bản, phần kế hoạch còn lại phải phù hợp DOC hiện tại và các ngày tiếp theo; các lần đã qua không được tự sinh bù, ghi hoàn thành hoặc cộng vào liều sau.

### BR-42

**English:** A new protocol version starts in DRAFT. DRAFT and REJECTED content may be edited; submission requires a complete plan with at least one valid operation and changes the version to PENDING_APPROVAL.

**Tiếng Việt:** Phiên bản phác đồ mới bắt đầu ở DRAFT. Nội dung DRAFT và REJECTED được sửa; gửi duyệt phải có kế hoạch đầy đủ với ít nhất một hoạt động hợp lệ và chuyển phiên bản sang PENDING_APPROVAL.

### BR-43

**English:** Only the Farm Owner may approve or reject a PENDING_APPROVAL protocol for their farm. Rejection requires a reason; the Expert cannot approve their own protocol.

**Tiếng Việt:** Chỉ Farm Owner được duyệt hoặc từ chối phác đồ PENDING_APPROVAL của trại mình. Từ chối phải có lý do; Expert không được tự duyệt phác đồ.

### BR-44

**English:** Submitted content cannot be edited while awaiting approval. APPROVED, SUPERSEDED and ABORTED content remains unchanged; changing approved instructions requires a new version, and all review decisions are retained.

**Tiếng Việt:** Nội dung đã gửi không được sửa trong khi chờ duyệt. Nội dung APPROVED, SUPERSEDED và ABORTED được giữ nguyên; thay đổi chỉ dẫn đã duyệt phải tạo phiên bản mới và mọi quyết định duyệt được lưu lại.

### BR-45

**English:** Protocol versions are numbered consecutively within the same type and target. Version 1 has no predecessor; every later version links to the preceding version for the same season or disease case.

**Tiếng Việt:** Phiên bản phác đồ được đánh số liên tiếp trong cùng loại và đối tượng áp dụng. Phiên bản 1 không có bản trước; mỗi phiên bản sau liên kết với phiên bản liền trước của cùng vụ hoặc ca bệnh.

### BR-46

**English:** Each season may have at most one APPROVED production protocol, and each disease case may have at most one APPROVED treatment protocol.

**Tiếng Việt:** Mỗi vụ chỉ có tối đa một phác đồ nuôi APPROVED và mỗi ca bệnh chỉ có tối đa một phác đồ điều trị APPROVED.

### BR-47

**English:** Approving a replacement version supersedes the previous approved version and cancels its unexecuted PLANNED schedules. Completed executions are retained; replacing a treatment version does not automatically resume production between versions.

**Tiếng Việt:** Duyệt phiên bản thay thế sẽ chuyển bản đã duyệt trước đó sang SUPERSEDED và hủy các lịch PLANNED chưa thực hiện của bản đó. Giữ nguyên các lần đã hoàn thành; thay phiên bản điều trị không tự tiếp tục lịch nuôi trong khoảng giữa hai bản.

### BR-48

**English:** Expert proposals remain proposals at submission. The Farm Owner must create any missing catalogue products and manufacturers before approval and link each proposal to the matching product; a matching name and unit alone do not establish the same product identity.

**Tiếng Việt:** Đề xuất của Expert vẫn là đề xuất khi gửi duyệt. Farm Owner phải tạo vật tư và NSX còn thiếu trong danh mục trước khi duyệt, rồi liên kết từng đề xuất với đúng vật tư; chỉ trùng tên và đơn vị chưa đủ xác định là cùng vật tư.

### BR-49

**English:** During review, the Farm Owner may only add or adjust the new product's low-stock threshold and the new manufacturer's contact name, phone and email. A change to the product identity, manufacturer, packaging or technical instructions requires rejection for the Expert to revise and resubmit.

**Tiếng Việt:** Khi duyệt, Farm Owner chỉ được bổ sung hoặc điều chỉnh ngưỡng cảnh báo tồn của vật tư mới và tên người liên hệ, số điện thoại, email của NSX mới. Thay đổi vật tư, NSX, quy cách hoặc chỉ dẫn kỹ thuật phải từ chối để Expert sửa và gửi lại.

## 7. DOSE

### BR-50

**English:** In production templates and production protocols, biomass-based dosing is allowed only from DOC 30. An item spanning earlier days must separate those days from its biomass-based period.

**Tiếng Việt:** Trong mẫu phác đồ nuôi và phác đồ nuôi, chỉ được tính liều theo sinh khối từ DOC 30. Mục có cả các ngày trước đó phải tách riêng giai đoạn chưa được dùng sinh khối.

### BR-51

**English:** A dose must match the product's instructions and application route. Feeding does not use a water-volume basis; chemicals use a fixed quantity or water-volume basis; minerals, medicines and other products use a basis appropriate to their stated use.

**Tiếng Việt:** Liều phải phù hợp với hướng dẫn và đường sử dụng của vật tư. Cho ăn không tính theo thể tích nước; hóa chất dùng lượng cố định hoặc tính theo thể tích nước; khoáng, thuốc và vật tư khác dùng cơ sở phù hợp với cách dùng đã khai báo.

### BR-52

**English:** The quantity for one occurrence is its fixed dose, dose per kilogram × biomass in kilograms, dose per cubic metre × water volume in cubic metres, or biomass × percentage / 100. Percentage dosing represents a mass and must be expressed in compatible mass units.

**Tiếng Việt:** Lượng cho một lần dùng bằng liều cố định, liều trên mỗi kg × sinh khối tính bằng kg, liều trên mỗi m³ × thể tích nước tính bằng m³, hoặc sinh khối × tỷ lệ phần trăm / 100. Liều theo phần trăm sinh khối là khối lượng và phải dùng đơn vị khối lượng phù hợp.

### BR-53

**English:** Only daily feeding with a fixed dose in kilograms or grams may increase by a fixed amount each day during DOC 1–29. The amount per meal equals its starting amount plus the daily increase × elapsed days from the item's dose anchor; rolling the schedule window does not restart this increase.

**Tiếng Việt:** Chỉ cữ cho ăn hằng ngày với liều cố định tính bằng kg hoặc gam được tăng thêm một lượng cố định mỗi ngày trong DOC 1–29. Lượng mỗi cữ bằng lượng ban đầu cộng mức tăng hằng ngày × số ngày từ mốc tăng liều của mục đó; dịch cửa sổ lịch không tính lại mức tăng từ đầu.

### BR-54

**English:** The Expert is responsible for reviewing the total daily and course doses and their consistency with product instructions before submitting a protocol.

**Tiếng Việt:** Expert chịu trách nhiệm kiểm tra tổng liều trong ngày, trong liệu trình và sự phù hợp với hướng dẫn vật tư trước khi gửi phác đồ.

## 8. SCHEDULE

### BR-55

**English:** Schedules require an APPROVED protocol and an ACTIVE season of an ACTIVE farm. Approval defines the plan and does not generate the whole season's schedules at once; execution must respect the protocol's effective period.

**Tiếng Việt:** Sinh lịch phải có phác đồ APPROVED, vụ ACTIVE và trại ACTIVE. Duyệt phác đồ xác lập kế hoạch, không sinh toàn bộ lịch vụ cùng lúc; thực hiện phải đúng thời gian có hiệu lực của phác đồ.

### BR-56

**English:** The schedule window is fixed at three calendar days: the remainder of today and the next two days in Vietnam time. It advances daily, adding missing eligible occurrences without duplicating existing ones or generating past occurrences.

**Tiếng Việt:** Cửa sổ lịch cố định ba ngày theo giờ Việt Nam: phần còn lại hôm nay và hai ngày tiếp theo. Cửa sổ dịch hằng ngày, bổ sung các lần đủ điều kiện còn thiếu, không tạo trùng hoặc sinh các lần đã qua.

### BR-57

**English:** The same protocol item and scheduled time may have at most one non-cancelled schedule. A completed occurrence must not be generated or executed again.

**Tiếng Việt:** Cùng một mục phác đồ và thời điểm chỉ có tối đa một lịch chưa bị hủy. Lần đã hoàn thành không được sinh hoặc thực hiện lại.

### BR-58

**English:** An occurrence that lacks valid required calculation inputs cannot be generated with an assumed quantity. The system must alert the responsible users and retry when suitable data becomes available; unaffected operations may still be scheduled.

**Tiếng Việt:** Lần dùng thiếu dữ liệu tính bắt buộc hợp lệ không được sinh bằng lượng giả định. Hệ thống phải cảnh báo người phụ trách và tính lại khi có dữ liệu phù hợp; các hoạt động không bị ảnh hưởng vẫn được lên lịch.

### BR-59

**English:** Each schedule retains the dose, calculation inputs, source record and calculation time used to determine its planned quantity. The saved quantity cannot be overwritten.

**Tiếng Việt:** Mỗi lịch lưu liều, dữ liệu tính, bản ghi nguồn và thời điểm tính lượng dự kiến. Lượng đã lưu không được sửa đè.

### BR-60

**English:** Changes to biomass, population estimates, usable water volume or source validity trigger recalculation of affected future PLANNED schedules within the window, including later occurrences on the same day. Replace the old schedule by cancelling it and creating a new one with valid inputs; if no valid basis remains, cancel it and alert rather than retain an invalid dose.

**Tiếng Việt:** Thay đổi sinh khối, ước tính quần thể, thể tích nước sử dụng hoặc hiệu lực nguồn phải kích hoạt tính lại lịch PLANNED tương lai bị ảnh hưởng trong cửa sổ, kể cả cữ sau trong cùng ngày. Thay lịch bằng cách hủy bản cũ và tạo bản mới có căn cứ hợp lệ; nếu không còn căn cứ thì hủy và cảnh báo, không giữ liều sai.

### BR-61

**English:** Recalculation is triggered after the relevant data is saved and is checked periodically as well; it does not wait until the next day. Replacing a schedule does not deduct stock, and cancellation and creation of an eligible replacement must succeed together.

**Tiếng Việt:** Tính lại được kích hoạt sau khi lưu dữ liệu liên quan và còn được kiểm tra định kỳ, không chờ đến ngày hôm sau. Thay lịch không trừ kho; hủy lịch và tạo bản thay thế đủ điều kiện phải cùng thành công.

### BR-62

**English:** A cancelled schedule remains as history with its reason, time and the responsible user or system process. It cannot return to PLANNED; a replacement is a new schedule, and a COMPLETED schedule cannot be replaced.

**Tiếng Việt:** Lịch bị hủy được giữ làm lịch sử cùng lý do, thời điểm và người hoặc tiến trình hệ thống thực hiện. Lịch đó không được trở lại PLANNED; lịch thay thế là bản mới và lịch COMPLETED không được thay thế.

### BR-63

**English:** An overdue PLANNED schedule remains overdue and is not automatically recalculated from later data. Recording a late execution must preserve its actual time and satisfy the current execution conditions.

**Tiếng Việt:** Lịch PLANNED quá giờ vẫn là lịch quá hạn và không tự được tính lại bằng dữ liệu đến sau. Ghi nhận thực hiện trễ phải giữ đúng thời điểm thực tế và đáp ứng các điều kiện thực hiện hiện hành.

## 9. EXECUTION

### BR-64

**English:** Only the current Technician of an ACTIVE season may record its water observations, shrimp-health observations, AI detection requests and operation executions.

**Tiếng Việt:** Chỉ KTV đương nhiệm của vụ ACTIVE được ghi nhận chất lượng nước, sức khỏe tôm, yêu cầu nhận diện AI và thực hiện vận hành của vụ đó.

### BR-65

**English:** Only a PLANNED schedule under an effective protocol may be executed. COMPLETED and CANCELLED schedules cannot be executed or reopened.

**Tiếng Việt:** Chỉ lịch PLANNED thuộc phác đồ đang có hiệu lực được thực hiện. Lịch COMPLETED và CANCELLED không được thực hiện hoặc mở lại.

### BR-66

**English:** An execution must use the approved product. A Technician cannot substitute a different product; a technical substitution requires a revised protocol approved by the Farm Owner.

**Tiếng Việt:** Lần thực hiện phải dùng đúng vật tư đã duyệt. KTV không được thay vật tư khác; thay vật tư theo chuyên môn phải có phác đồ sửa đổi được Farm Owner duyệt.

### BR-67

**English:** For production operations, the Technician records the actual quantity used. If its percentage difference from the planned quantity exceeds the protocol's allowed variance, a reason is mandatory.

**Tiếng Việt:** Với hoạt động theo phác đồ nuôi, KTV ghi lượng thực tế đã dùng. Nếu tỷ lệ chênh lệch so với lượng dự kiến vượt mức cho phép của phác đồ thì bắt buộc có lý do.

### BR-68

**English:** Treatment must follow the approved dose and has no allowed variance. Any actual quantity deviation must still be recorded accurately, with a mandatory reason and notification to the current Expert and Farm Owner; recording it does not authorize the Technician to change the prescription.

**Tiếng Việt:** Điều trị phải theo liều đã duyệt và không có mức sai lệch cho phép. Mọi sai lệch lượng thực dùng vẫn phải được ghi đúng, kèm lý do bắt buộc và thông báo cho Expert đương nhiệm, Farm Owner; ghi nhận sai lệch không trao quyền cho KTV tự đổi chỉ định.

### BR-69

**English:** The actual quantity must be positive and the execution time cannot be in the future. If an operation has not been performed, the Technician reports the issue without recording consumption or marking it complete.

**Tiếng Việt:** Lượng thực dùng phải dương và thời điểm thực hiện không được ở tương lai. Nếu chưa thực hiện, KTV báo sự cố mà không ghi tiêu hao hoặc đánh dấu hoàn thành.

### BR-70

**English:** Each schedule may have only one successful execution. Recording the execution, deducting stock and completing the schedule must succeed together; submitting the same execution again must not deduct stock twice.

**Tiếng Việt:** Mỗi lịch chỉ có một lần thực hiện thành công. Ghi nhận thực hiện, trừ kho và hoàn thành lịch phải cùng thành công; gửi lại cùng một lần thực hiện không được trừ kho hai lần.

## 10. WATER

### BR-71

**English:** Water readings must satisfy the project's input limits: temperature 0–50 °C, pH 0–14, and non-negative dissolved oxygen, salinity, ammonia, nitrite, alkalinity and hydrogen sulphide. Readings outside these limits are rejected.

**Tiếng Việt:** Chỉ số nước phải đáp ứng giới hạn nhập liệu của đồ án: nhiệt độ 0–50 °C, pH 0–14; oxy hòa tan, độ mặn, amoniac, nitrit, độ kiềm và hydro sunfua không âm. Giá trị ngoài các giới hạn này bị từ chối.

### BR-72

**English:** Saved water readings cannot be edited. Only the current Technician of an ACTIVE season may void an incorrect record, with a mandatory reason, while retaining the original record, the person and the time of voiding.

**Tiếng Việt:** Chỉ số nước đã lưu không được sửa. Chỉ KTV đương nhiệm của vụ ACTIVE được hủy hiệu lực bản ghi sai, kèm lý do bắt buộc và giữ lại bản ghi gốc, người hủy, thời điểm hủy.

### BR-73

**English:** Water statistics and operational calculations use only non-voided records from the relevant season.

**Tiếng Việt:** Thống kê nước và tính toán vận hành chỉ dùng bản ghi chưa bị hủy hiệu lực của đúng vụ.

### BR-74

**English:** A reading within the input limits but outside the warning range for the season's shrimp type is retained and alerts the Farm Owner and current Technician and Expert. A warning does not automatically change a protocol.

**Tiếng Việt:** Chỉ số nằm trong giới hạn nhập liệu nhưng ngoài ngưỡng cảnh báo của loại tôm trong vụ vẫn được lưu và cảnh báo cho Farm Owner, KTV và Expert đương nhiệm. Cảnh báo không tự thay đổi phác đồ.

## 11. HEALTH

### BR-75

**English:** Saved shrimp-health records cannot be edited. Only the current Technician of an ACTIVE season may void an incorrect record, with a mandatory reason; the original record, the person and the time of voiding are retained.

**Tiếng Việt:** Bản ghi sức khỏe tôm đã lưu không được sửa. Chỉ KTV đương nhiệm của vụ ACTIVE được hủy hiệu lực bản ghi sai, kèm lý do bắt buộc; bản ghi gốc, người hủy và thời điểm hủy được giữ lại.

### BR-76

**English:** Sample count, average weight and average length must be positive when provided. Mortality, estimated live population and estimated biomass cannot be negative.

**Tiếng Việt:** Số con lấy mẫu, trọng lượng trung bình và chiều dài trung bình phải dương khi được cung cấp. Số tôm chết, quần thể sống ước tính và sinh khối ước tính không được âm.

### BR-77

**English:** A biomass source must be the latest suitable non-voided record from the same season, with a positive biomass estimate and no more than seven days (168 hours) old at the scheduled occurrence. It must follow the latest partial harvest and remain consistent with newer population information.

**Tiếng Việt:** Nguồn sinh khối phải là bản ghi phù hợp mới nhất, chưa bị hủy hiệu lực, cùng vụ, có sinh khối ước tính dương và không quá bảy ngày (168 giờ) tại thời điểm dự kiến thực hiện. Nguồn phải sau lần thu tỉa gần nhất và còn phù hợp với thông tin quần thể mới hơn.

### BR-78

**English:** Daily health observations do not count as a new weight sample. The original quantitative source time must be retained; adding comments, copying an old weight or updating population alone cannot renew that weight's seven-day limit.

**Tiếng Việt:** Theo dõi sức khỏe hằng ngày không được coi là cân mẫu mới. Phải giữ mốc dữ liệu định lượng gốc; thêm nhận xét, sao chép trọng lượng cũ hoặc chỉ cập nhật quần thể không làm mới thời hạn bảy ngày của trọng lượng đó.

### BR-79

**English:** When biomass is omitted but estimated live population and average weight are positive, biomass in kilograms equals population × average weight in grams / 1000, rounded to three decimal places. Missing inputs do not produce an estimate.

**Tiếng Việt:** Khi không nhập sinh khối nhưng có quần thể sống ước tính và trọng lượng trung bình dương, sinh khối tính bằng kg bằng số con × trọng lượng trung bình tính bằng gam / 1000, làm tròn ba số thập phân. Thiếu dữ liệu thì không tự tạo ước tính.

### BR-80

**English:** Mortality records the newly observed deaths for the stated observation period, not a repeated cumulative total. A live-population estimate represents the shrimp still alive at that time; those deaths must not be subtracted from it again.

**Tiếng Việt:** Số tôm chết ghi nhận số chết mới trong khoảng theo dõi, không nhập lại tổng lũy kế nhiều lần. Quần thể sống ước tính là số tôm còn sống tại thời điểm đó; không được trừ số chết thêm lần nữa vào số này.

### BR-81

**English:** Voided health records are excluded from health, growth and biomass calculations. Unexecuted schedules that depend on a voided source must be re-evaluated before use; completed records remain unchanged.

**Tiếng Việt:** Bản ghi sức khỏe đã hủy hiệu lực bị loại khỏi tính toán sức khỏe, tăng trưởng và sinh khối. Lịch chưa thực hiện phụ thuộc nguồn bị hủy phải được xem xét lại trước khi dùng; các bản ghi đã hoàn thành được giữ nguyên.

## 12. SUPPLIER

### BR-82

**English:** Each supplier belongs to one Farm Owner. That Owner uses the same supplier directory across their farms and cannot manage or select another Owner's suppliers.

**Tiếng Việt:** Mỗi nhà cung cấp thuộc một Farm Owner. Owner dùng chung danh bạ nhà cung cấp cho các trại của mình và không được quản lý hoặc chọn nhà cung cấp của Owner khác.

### BR-83

**English:** A supplier must be identified as a manufacturer, distributor or both. Only a manufacturer or both may be recorded as a product's manufacturer; any of the three types may sell a stock receipt.

**Tiếng Việt:** Nhà cung cấp phải được xác định là nhà sản xuất, nhà phân phối hoặc cả hai. Chỉ loại nhà sản xuất hoặc cả hai được ghi làm NSX của vật tư; cả ba loại đều có thể là bên bán trên phiếu nhập.

### BR-84

**English:** The manufacturer selected for a new product must be active and belong to the Farm Owner who owns the product's farm. A distributor or importer is not treated as the manufacturer merely because it supplies the product or holds its receipt code.

**Tiếng Việt:** NSX được chọn cho vật tư mới phải đang hoạt động và thuộc Farm Owner sở hữu trại của vật tư. Nhà phân phối hoặc nhà nhập khẩu không được coi là NSX chỉ vì cung cấp hàng hoặc đứng tên mã tiếp nhận.

### BR-85

**English:** An inactive supplier cannot be selected for a new product dossier or stock receipt. Previously linked products may still be used if they remain active and eligible; supplier deactivation does not change their history or status.

**Tiếng Việt:** Nhà cung cấp ngừng hoạt động không được chọn cho hồ sơ vật tư hoặc lần nhập kho mới. Vật tư đã liên kết vẫn được dùng nếu còn hoạt động và đủ điều kiện; tắt nhà cung cấp không đổi lịch sử hoặc trạng thái của vật tư.

### BR-86

**English:** A supplier's name and type cannot be changed after being referenced by business records, while contact details may be updated. A supplier linked as a manufacturer cannot be reclassified as distributor-only.

**Tiếng Việt:** Tên và loại nhà cung cấp không được đổi sau khi đã được hồ sơ nghiệp vụ tham chiếu, nhưng thông tin liên hệ được cập nhật. Nhà cung cấp đang được liên kết làm NSX không được đổi thành chỉ phân phối.

## 13. PRODUCT

### BR-87

**English:** Only the Farm Owner may create and manage catalogue products for their farms. Each product belongs permanently to one farm, and its name and stock unit together must be unique within that farm.

**Tiếng Việt:** Chỉ Farm Owner được tạo và quản lý vật tư trong danh mục của các trại mình. Mỗi vật tư gắn cố định với một trại và tổ hợp tên, đơn vị kho phải duy nhất trong trại đó.

### BR-88

**English:** Each product has one operational category and one declared regulatory type: feed, environment, dual_purpose or medicine. The regulatory type follows the product dossier and label, not its operational category alone.

**Tiếng Việt:** Mỗi vật tư có một nhóm sử dụng và một loại pháp lý được khai báo: feed, environment, dual_purpose hoặc medicine. Loại pháp lý theo hồ sơ và nhãn vật tư, không chỉ suy ra từ nhóm sử dụng.

### BR-89

**English:** Every catalogue product and saved product proposal must identify its manufacturer and include complete product and compliance information. An incomplete proposal cannot be saved in a template or protocol.

**Tiếng Việt:** Mọi vật tư trong danh mục và đề xuất vật tư được lưu phải xác định NSX, có đủ thông tin vật tư và hồ sơ tuân thủ. Đề xuất thiếu thông tin không được lưu vào mẫu hoặc phác đồ.

### BR-90

**English:** Each product has exactly one compliance dossier containing its regulatory type, receipt or registration number, ingredients, usage instructions and an explicit antibiotic classification. Evidence links are optional and do not replace the required information.

**Tiếng Việt:** Mỗi vật tư có đúng một hồ sơ tuân thủ gồm loại pháp lý, mã tiếp nhận hoặc số đăng ký, thành phần, hướng dẫn sử dụng và xác định rõ có hay không có kháng sinh. Liên kết bằng chứng là tùy chọn và không thay thế thông tin bắt buộc.

### BR-91

**English:** A medicine requires a declared non-negative withdrawal period; other products require one when their instructions specify it. An explicitly declared zero is valid, but a missing required period cannot be treated as zero.

**Tiếng Việt:** Thuốc phải khai báo thời gian ngừng không âm; vật tư khác phải khai báo khi hướng dẫn có yêu cầu. Giá trị 0 được khai báo rõ là hợp lệ, nhưng thời gian ngừng bắt buộc còn thiếu không được coi là 0.

### BR-92

**English:** PACK and BOTTLE stock units require a positive package conversion quantity and its unit; other stock units have no package conversion. After the first stock movement, the stock unit and conversion cannot change; a different package size requires a separate product.

**Tiếng Việt:** Đơn vị kho PACK và BOTTLE phải có lượng quy đổi đóng gói dương và đơn vị quy đổi; đơn vị kho khác không khai báo quy đổi đóng gói. Sau lần nhập xuất kho đầu tiên, đơn vị kho và quy đổi không được đổi; quy cách khác phải tạo vật tư riêng.

### BR-93

**English:** OCR may suggest label information, but the person creating or proposing the product must check and confirm it. OCR output is not independent proof of compliance.

**Tiếng Việt:** OCR được gợi ý thông tin từ nhãn nhưng người tạo hoặc đề xuất vật tư phải kiểm tra và xác nhận. Kết quả OCR không phải bằng chứng tuân thủ độc lập.

### BR-94

**English:** Product creation, proposal, protocol submission, approval, schedule generation and execution must reject products matching the configured prohibited-ingredient list. Passing these checks does not constitute regulatory certification of the product or its registration number.

**Tiếng Việt:** Tạo vật tư, đề xuất, gửi và duyệt phác đồ, sinh lịch, thực hiện đều phải từ chối vật tư khớp danh mục thành phần cấm đã cấu hình. Vượt qua các kiểm tra này không đồng nghĩa vật tư hoặc số đăng ký đã được cơ quan quản lý chứng nhận.

### BR-95

**English:** A catalogue product selected for a new protocol submission, approval, schedule or execution must be active and have a complete, suitable dossier. Ineligible products are blocked from new use while historical records are retained.

**Tiếng Việt:** Vật tư trong danh mục được chọn để gửi, duyệt phác đồ, sinh lịch hoặc thực hiện mới phải đang hoạt động, có hồ sơ đầy đủ và phù hợp. Vật tư không đủ điều kiện bị chặn dùng mới nhưng lịch sử được giữ nguyên.

### BR-96

**English:** The Farm Owner may deactivate a product at any time, even if stock remains. Deactivation prevents further use and cancels its unexecuted PLANNED schedules, without deleting stock or history.

**Tiếng Việt:** Farm Owner được ngừng sử dụng vật tư bất kỳ lúc nào, kể cả khi còn tồn kho. Ngừng sử dụng sẽ chặn dùng tiếp và hủy các lịch PLANNED chưa thực hiện của vật tư, không xóa tồn kho hoặc lịch sử.

### BR-97

**English:** A product may have at most three label images, and its low-stock threshold cannot be negative.

**Tiếng Việt:** Mỗi vật tư có tối đa ba ảnh nhãn và ngưỡng cảnh báo tồn kho thấp không được âm.

### BR-98

**English:** After the first recorded pond use, the manufacturer, regulatory type, receipt or registration number, ingredients, usage instructions, label images and antibiotic classification cannot be changed. Recorded execution details and withdrawal snapshots remain unchanged.

**Tiếng Việt:** Sau lần ghi nhận sử dụng xuống ao đầu tiên, NSX, loại pháp lý, mã tiếp nhận hoặc số đăng ký, thành phần, hướng dẫn dùng, ảnh nhãn và phân loại kháng sinh không được đổi. Thông tin thực hiện và thời gian ngừng đã ghi tại lần dùng được giữ nguyên.

### BR-99

**English:** Feed, environment and dual-purpose dossiers use the corresponding 01-, 02- and 03- receipt-code types; medicine dossiers use a circulation registration number. The code holder and manufacturer may be different; the person providing the dossier is responsible for matching the code to the product.

**Tiếng Việt:** Hồ sơ feed, environment và dual_purpose dùng loại mã tiếp nhận tương ứng 01-, 02- và 03-; hồ sơ thuốc dùng số đăng ký lưu hành. Bên đứng tên mã và NSX có thể khác nhau; người cung cấp hồ sơ chịu trách nhiệm đối chiếu mã đúng vật tư.

### BR-100

**English:** An antibiotic product must be classified as medicine and may be used only in an approved treatment protocol linked to a disease case. It cannot appear in production templates or production protocols; a non-antibiotic medicine may be used in production when its stated indication allows it.

**Tiếng Việt:** Vật tư chứa kháng sinh phải thuộc loại medicine và chỉ được dùng trong phác đồ điều trị đã duyệt, gắn ca bệnh. Vật tư này không được xuất hiện trong mẫu hoặc phác đồ nuôi; thuốc không kháng sinh được dùng trong nuôi khi chỉ định của vật tư cho phép.

## 14. INVENTORY

### BR-101

**English:** Each stock receipt records one delivery with its own quantity, purchase price and seller. Deliveries of the same product and manufacturer lot must share the same expiry date.

**Tiếng Việt:** Mỗi lần nhập kho ghi một lần giao hàng với số lượng, giá mua và bên bán riêng. Các lần giao cùng vật tư và cùng lô NSX phải có chung ngày hết hạn.

### BR-102

**English:** Stock-in requires an active product, a supplier selected from the Owner's directory, the manufacturer lot number, quantity, purchase price and expiry date. Free-text supplier names do not replace the supplier record.

**Tiếng Việt:** Nhập kho phải có vật tư đang hoạt động, nhà cung cấp được chọn từ danh bạ của Owner, mã lô NSX, số lượng, giá mua và ngày hết hạn. Tên nhà cung cấp nhập tự do không thay thế hồ sơ nhà cung cấp.

### BR-103

**English:** Execution consumes eligible stock in earliest-expiry order, then earliest-received order for equal expiry dates. Stock with a missing or expired expiry date cannot be used in pond operations; expired stock may only be disposed of or returned.

**Tiếng Việt:** Khi thực hiện, hàng đủ điều kiện được xuất theo hạn dùng sớm nhất, cùng hạn thì xuất lần nhập sớm hơn. Hàng thiếu hoặc quá hạn dùng không được dùng vận hành ao; hàng quá hạn chỉ được tiêu hủy hoặc trả lại.

### BR-104

**English:** Stock balances cannot become negative. Inventory history is retained, and every correction requires a reason and a new adjustment entry rather than editing an earlier movement.

**Tiếng Việt:** Tồn kho không được âm. Lịch sử kho được giữ nguyên; mọi sửa sai phải có lý do và ghi bằng lần điều chỉnh mới, không sửa lần nhập xuất trước đó.

### BR-105

**English:** Consumption must be converted to the product's stock unit using its declared conversion. Units of mass and volume cannot be interchanged without a valid conversion basis, and stock deductions must match the recorded movements.

**Tiếng Việt:** Lượng dùng phải được quy đổi về đơn vị kho theo quy đổi đã khai báo của vật tư. Không được đổi giữa đơn vị khối lượng và thể tích khi không có căn cứ quy đổi hợp lệ; lượng trừ tồn phải khớp các lần nhập xuất đã ghi.

### BR-106

**English:** Schedule generation does not reserve or deduct stock. Available quantity and lot eligibility are checked when the execution is recorded.

**Tiếng Việt:** Sinh lịch không giữ trước hoặc trừ tồn kho. Số lượng đủ dùng và điều kiện lô được kiểm tra khi ghi nhận thực hiện.

### BR-107

**English:** Only the Farm Owner may record manual stock movements. A manual stock-out requires a chosen receipt balance and a reason, preserves its unit cost and cannot exceed its balance; it is for disposal, return or use outside pond operations.

**Tiếng Việt:** Chỉ Farm Owner được ghi nhập xuất kho thủ công. Xuất thủ công phải chọn phần tồn của một lần nhập, có lý do, giữ giá vốn của lần nhập đó và không vượt số còn lại; chỉ dùng cho tiêu hủy, trả hàng hoặc sử dụng ngoài vận hành ao.

### BR-108

**English:** Materials used in pond operations must be issued through a Technician's execution and linked to that execution and season. A manual stock-out without an operational reference cannot be assigned to a season.

**Tiếng Việt:** Vật tư dùng vận hành ao phải được xuất qua lần thực hiện của KTV và liên kết với lần thực hiện, vụ tương ứng. Xuất thủ công không có tham chiếu vận hành không được gán cho vụ.

### BR-109

**English:** Stock below the product's threshold alerts the Farm Owner and the current staff of affected seasons. Insufficient eligible stock blocks execution and alerts the Farm Owner and executing Technician; the system cannot silently reduce the quantity.

**Tiếng Việt:** Tồn dưới ngưỡng của vật tư phải cảnh báo Farm Owner và nhân sự đương nhiệm của các vụ bị ảnh hưởng. Không đủ hàng hợp lệ phải chặn thực hiện và cảnh báo Farm Owner, KTV đang thao tác; hệ thống không được âm thầm giảm lượng dùng.

## 15. CASE

### BR-110

**English:** Only the current Technician of an ACTIVE season may create a disease case. The case starts OPEN and is assigned to the current Expert; linked AI results and related cases must belong to the same season.

**Tiếng Việt:** Chỉ KTV đương nhiệm của vụ ACTIVE được tạo ca bệnh. Ca bắt đầu ở OPEN và được giao cho Expert đương nhiệm; kết quả AI và ca liên quan được gắn phải thuộc cùng vụ.

### BR-111

**English:** A season may have at most one unresolved disease case across OPEN, WAITING_FOR_INFO, MONITORING and IN_TREATMENT. Symptoms from the same episode are recorded in that case.

**Tiếng Việt:** Mỗi vụ chỉ có tối đa một ca chưa giải quyết trong các trạng thái OPEN, WAITING_FOR_INFO, MONITORING và IN_TREATMENT. Các triệu chứng trong cùng đợt bệnh được ghi vào ca đó.

### BR-112

**English:** Only the case's current Technician and Expert may add replies. The Technician provides information, monitoring results, treatment results or emergency alerts; the Expert requests information, assesses the case, gives instructions or records a resolution.

**Tiếng Việt:** Chỉ KTV và Expert đang phụ trách ca được thêm phản hồi. KTV cung cấp thông tin, kết quả theo dõi, kết quả điều trị hoặc báo khẩn; Expert yêu cầu thông tin, đánh giá, hướng dẫn hoặc ghi kết luận.

### BR-113

**English:** Only the responsible Expert may resolve a case, with a mandatory resolution summary, recorded person and time. A RESOLVED case cannot receive further replies or be reopened; a relapse creates a new case.

**Tiếng Việt:** Chỉ Expert phụ trách được kết luận ca, kèm tóm tắt bắt buộc, người kết luận và thời điểm. Ca RESOLVED không nhận phản hồi thêm hoặc mở lại; tái phát phải tạo ca mới.

### BR-114

**English:** A case with an active treatment course cannot be resolved or moved out of IN_TREATMENT to bypass remaining doses. Treatment must first be completed or stopped by the Expert under the treatment rules.

**Tiếng Việt:** Ca còn liệu trình có hiệu lực không được kết luận hoặc chuyển khỏi IN_TREATMENT để bỏ các liều còn lại. Điều trị phải hoàn tất hoặc được Expert dừng theo quy tắc điều trị trước.

## 16. TREATMENT

### BR-115

**English:** The Expert specifies the treatment start date and time, and the Farm Owner must approve the protocol before that time. Treatment becomes effective and its case enters IN_TREATMENT at the approved start, not at submission or approval; the protocol and case must belong to the same ACTIVE season.

**Tiếng Việt:** Expert xác định ngày, giờ bắt đầu điều trị và Farm Owner phải duyệt phác đồ trước mốc đó. Điều trị có hiệu lực và ca chuyển IN_TREATMENT tại mốc bắt đầu đã duyệt, không phải lúc gửi hoặc duyệt; phác đồ và ca phải thuộc cùng vụ ACTIVE.

### BR-116

**English:** If the proposed treatment start has passed before approval, the protocol must be returned to the Expert to revise and resubmit. Treatment occurrences cannot precede its start, and the system cannot automatically skip, combine or shift doses to compensate for late approval.

**Tiếng Việt:** Nếu mốc bắt đầu điều trị đã qua trước khi duyệt, phác đồ phải trả Expert sửa và gửi lại. Các lần dùng không được trước mốc bắt đầu và hệ thống không tự bỏ, gộp hoặc dời liều để bù việc duyệt trễ.

### BR-117

**English:** After approval, future treatment schedules within the three-day window may be prepared before the treatment start, but cannot be executed early. A delay or failure that prevents a required dose must be reported for the Expert to decide how the course proceeds.

**Tiếng Việt:** Sau khi duyệt, được chuẩn bị lịch điều trị tương lai trong cửa sổ ba ngày trước lúc bắt đầu nhưng không được thực hiện sớm. Trễ hoặc lỗi làm không thể thực hiện liều bắt buộc phải được báo để Expert quyết định cách tiếp tục liệu trình.

### BR-118

**English:** Production operations before the approved treatment start may continue. Production schedules conflicting with treatment are cancelled, including unexecuted overdue production schedules at its start; no production occurrence may be generated or executed for the treatment period, while the approved production protocol and completed history are retained.

**Tiếng Việt:** Hoạt động nuôi trước mốc điều trị đã duyệt được tiếp tục. Lịch nuôi xung đột với điều trị phải bị hủy, kể cả lịch nuôi quá hạn chưa thực hiện khi điều trị bắt đầu; không được sinh hoặc thực hiện cữ nuôi trong thời gian điều trị, đồng thời giữ phác đồ nuôi đã duyệt và lịch sử hoàn thành.

### BR-119

**English:** The Expert must include the feeding and care activities that should continue during treatment in the treatment protocol. Cancelling production schedules does not itself prescribe stopping feeding or care.

**Tiếng Việt:** Expert phải đưa các hoạt động cho ăn và chăm sóc cần tiếp tục trong thời gian điều trị vào phác đồ điều trị. Hủy lịch nuôi không tự đồng nghĩa với chỉ định ngừng cho ăn hoặc chăm sóc.

### BR-120

**English:** Treatment follows the same approval and version rules as production, but has no source template or allowed quantity variance. Treatment days start on its effective date, independently of culture DOC; the production DOC-30 restriction does not apply to treatment days.

**Tiếng Việt:** Điều trị theo cùng quy tắc duyệt và phiên bản với phác đồ nuôi nhưng không có mẫu nguồn hoặc tỷ lệ sai lệch lượng cho phép. Ngày điều trị tính từ ngày có hiệu lực, độc lập với DOC của vụ; không áp mốc DOC 30 của phác đồ nuôi vào ngày điều trị.

### BR-121

**English:** Treatment automatically finishes after every required occurrence in the entire course has been performed. The case moves to MONITORING and eligible production scheduling resumes; an empty three-day window or a generation failure does not mean the course is complete.

**Tiếng Việt:** Điều trị tự hoàn tất sau khi đã thực hiện đủ mọi lần bắt buộc trong toàn bộ liệu trình. Ca chuyển sang MONITORING và hệ thống tiếp tục lên lịch nuôi đủ điều kiện; cửa sổ ba ngày trống hoặc lỗi sinh lịch không đồng nghĩa liệu trình đã xong.

### BR-122

**English:** Only the current Expert may stop an APPROVED, effective treatment protocol early, with a mandatory clinical reason. The protocol becomes ABORTED and retains the reason, person and time.

**Tiếng Việt:** Chỉ Expert đương nhiệm được dừng sớm phác đồ điều trị APPROVED đang có hiệu lực, kèm lý do chuyên môn bắt buộc. Phác đồ chuyển sang ABORTED và lưu lý do, người dừng, thời điểm.

### BR-123

**English:** Stopping treatment cancels all its unexecuted PLANNED schedules, preserves completed executions, moves the case to MONITORING and immediately notifies the Technician and Farm Owner.

**Tiếng Việt:** Dừng điều trị sẽ hủy mọi lịch PLANNED chưa thực hiện của liệu trình, giữ các lần đã hoàn thành, chuyển ca sang MONITORING và thông báo ngay cho KTV, Farm Owner.

### BR-124

**English:** After an early treatment stop, production scheduling remains paused until the current Expert confirms that production may resume. Confirmation is retained with the person and time and does not replace Owner approval for any revised protocol.

**Tiếng Việt:** Sau khi dừng điều trị sớm, lịch nuôi tiếp tục tạm dừng đến khi Expert đương nhiệm xác nhận được tiếp tục nuôi. Xác nhận được lưu cùng người thực hiện, thời điểm và không thay thế việc Owner duyệt phác đồ nếu có sửa đổi.

### BR-125

**English:** After treatment stops, the Expert may prepare a replacement version immediately. It requires Owner approval and its own valid start time; approving a replacement does not itself release an existing pause on production.

**Tiếng Việt:** Sau khi điều trị dừng, Expert được chuẩn bị phiên bản thay thế ngay. Bản đó cần Owner duyệt và có mốc bắt đầu hợp lệ riêng; duyệt bản thay thế không tự gỡ việc tạm dừng lịch nuôi đang có.

### BR-126

**English:** A Technician may raise an emergency alert on an unresolved case but cannot stop treatment or approve a protocol. The current Expert assesses the alert and decides on the technical response.

**Tiếng Việt:** KTV được báo khẩn trên ca chưa giải quyết nhưng không được dừng điều trị hoặc duyệt phác đồ. Expert đương nhiệm đánh giá cảnh báo và quyết định xử lý chuyên môn.

### BR-127

**English:** When production resumes, new schedules follow the current culture DOC and valid current inputs. Cancelled production schedules are not restored, and missed occurrences from the treatment period are not automatically made up.

**Tiếng Việt:** Khi trở lại phác đồ nuôi, lịch mới tính theo DOC hiện tại và dữ liệu hiện hành hợp lệ. Không khôi phục lịch nuôi đã hủy hoặc tự chạy bù các lần đã bỏ trong thời gian điều trị.

## 17. HARVEST

### BR-128

**English:** Only the Farm Owner may record harvests for their ACTIVE seasons. Harvest weight must be positive, and the harvest time must be on or after stocking and not in the future.

**Tiếng Việt:** Chỉ Farm Owner được ghi thu hoạch cho vụ ACTIVE của mình. Khối lượng thu phải dương; thời điểm thu không được trước ngày thả giống hoặc ở tương lai.

### BR-129

**English:** A PARTIAL harvest may occur repeatedly and requires a positive harvested count and estimated remaining live count. A FINAL harvest may occur only once, leaves no shrimp in the season and completes it.

**Tiếng Việt:** Thu PARTIAL được lặp lại và phải có số con đã thu, số con sống còn lại ước tính đều dương. Thu FINAL chỉ được ghi một lần, không còn tôm trong vụ và hoàn thành vụ.

### BR-130

**English:** A food-sale harvest is allowed only after all applicable withdrawal periods from actual product use have ended. For each recorded use, the end time equals its actual time plus the greater of the recorded and current withdrawal days × 24 hours; the latest end time governs the harvest.

**Tiếng Việt:** Thu hoạch để bán làm thực phẩm chỉ được phép khi hết mọi thời gian ngừng áp dụng từ các lần thực dùng vật tư. Với mỗi lần dùng đã ghi, thời điểm hết ngừng bằng thời điểm thực dùng cộng giá trị lớn hơn giữa ngày ngừng đã ghi và hiện tại × 24 giờ; phải chờ đến thời điểm muộn nhất.

### BR-131

**English:** A missing required withdrawal value blocks harvest until it is clarified. Deactivating a product, stopping treatment or correcting its dossier cannot remove the protection established by a recorded use.

**Tiếng Việt:** Thiếu giá trị ngừng bắt buộc sẽ chặn thu hoạch đến khi được làm rõ. Ngừng vật tư, dừng điều trị hoặc sửa hồ sơ không được xóa thời gian bảo vệ từ lần dùng đã ghi.

### BR-132

**English:** An inactive product does not by itself prevent harvest. Harvest remains subject to the withdrawal requirements of actual uses and the other harvest conditions.

**Tiếng Việt:** Vật tư ngừng sử dụng không tự làm chặn thu hoạch. Lần thu vẫn phải đáp ứng thời gian ngừng từ các lần thực dùng và các điều kiện thu hoạch khác.

### BR-133

**English:** A partial harvest does not reset withdrawal periods. Any later actual use creates its own withdrawal requirement.

**Tiếng Việt:** Thu tỉa không đặt lại thời gian ngừng. Mỗi lần thực dùng sau đó tạo yêu cầu ngừng tương ứng.

### BR-134

**English:** When the harvested count plus the estimated remaining count exceeds the available population estimate, the Farm Owner must provide a reason. The measured harvest and new remaining estimate are retained instead of being reduced to fit the old estimate.

**Tiếng Việt:** Khi số con thu cộng số còn lại ước tính vượt quần thể đang ước tính, Farm Owner phải nêu lý do. Số thu thực tế và ước tính còn lại mới được giữ nguyên, không tự giảm để khớp ước tính cũ.

### BR-135

**English:** Dead shrimp must not be recorded as a commercial harvest. Mortality is recorded in health observations; withdrawal requirements do not prevent reporting deaths or cancelling a season lost to mass mortality.

**Tiếng Việt:** Tôm chết không được ghi thành thu hoạch thương mại. Số chết được ghi trong nhật ký sức khỏe; yêu cầu ngừng không chặn báo cáo tôm chết hoặc hủy vụ mất đàn do chết hàng loạt.

### BR-136

**English:** The project sets no minimum culture age for harvest. Culture age alone cannot block a harvest that meets the applicable harvest conditions.

**Tiếng Việt:** Đồ án không quy định tuổi nuôi tối thiểu để thu hoạch. Riêng tuổi nuôi không được chặn lần thu đáp ứng các điều kiện thu hoạch áp dụng.

### BR-137

**English:** Average harvest size in shrimp per kilogram equals the known harvested count divided by harvest weight in kilograms. If the count is unknown, average size remains unspecified.

**Tiếng Việt:** Cỡ thu tính bằng con/kg bằng số con thu đã biết chia khối lượng thu tính bằng kg. Nếu chưa biết số con thì cỡ thu để chưa xác định.

### BR-138

**English:** Harvest revenue equals weight × price per kilogram, rounded to two decimal places. An unknown price leaves revenue unspecified; a price explicitly recorded as zero produces zero revenue.

**Tiếng Việt:** Doanh thu thu hoạch bằng khối lượng × giá mỗi kg, làm tròn hai số thập phân. Chưa biết giá thì doanh thu chưa xác định; giá được ghi rõ bằng 0 mới cho doanh thu bằng 0.

### BR-139

**English:** Recording the same harvest request again must not create a second event. A new harvest must occur after the latest recorded harvest of that season; a backdated execution must not invalidate withdrawal compliance of an already recorded harvest.

**Tiếng Việt:** Gửi lại cùng một yêu cầu thu hoạch không được tạo lần thu thứ hai. Lần thu mới phải sau lần thu gần nhất đã ghi của vụ; ghi lùi thời điểm thực dùng không được làm vi phạm thời gian ngừng của lần thu đã ghi.

## 18. TASK

### BR-140

**English:** Only the Farm Owner may assign tasks, and only to ACTIVE Technicians under their management. A task linked to a season must be assigned to that season's current Technician; a farm-level task may be assigned to another eligible Technician of the same Owner.

**Tiếng Việt:** Chỉ Farm Owner được giao việc và chỉ giao cho KTV ACTIVE thuộc quyền quản lý. Việc gắn với vụ phải giao cho KTV đương nhiệm của vụ; việc cấp trại được giao cho KTV đủ điều kiện khác của cùng Owner.

### BR-141

**English:** A task starts in PENDING and has only four statuses: PENDING, IN_PROGRESS, COMPLETED and CANCELLED. An unfinished task with a deadline in the past is overdue without changing its status.

**Tiếng Việt:** Công việc bắt đầu ở PENDING và chỉ có bốn trạng thái: PENDING, IN_PROGRESS, COMPLETED và CANCELLED. Việc chưa kết thúc có hạn chót đã qua được tính là quá hạn, không đổi thành trạng thái riêng.

### BR-142

**English:** Only the assigned Technician may progress a task from PENDING to IN_PROGRESS and then to COMPLETED. Skipping a step, reversing progress or reopening a completed or cancelled task is not allowed.

**Tiếng Việt:** Chỉ KTV được giao mới được chuyển việc từ PENDING sang IN_PROGRESS rồi sang COMPLETED. Không được bỏ bước, chuyển lùi hoặc mở lại việc đã hoàn thành hay đã hủy.

### BR-143

**English:** Only the Farm Owner may cancel a PENDING or IN_PROGRESS task, with a mandatory reason. Cancellation retains the task's previous progress and history.

**Tiếng Việt:** Chỉ Farm Owner được hủy việc PENDING hoặc IN_PROGRESS, kèm lý do bắt buộc. Hủy việc vẫn giữ tiến độ trước đó và lịch sử của việc.

### BR-144

**English:** Task start and completion times must match their progress, with completion no earlier than start. A deadline provided when a task is created or revised must be in the future.

**Tiếng Việt:** Thời điểm bắt đầu và hoàn thành phải khớp tiến độ, thời điểm hoàn thành không trước bắt đầu. Hạn chót được cung cấp khi tạo hoặc sửa việc phải ở tương lai.

## 19. NOTIFICATION

### BR-145

**English:** Operational notifications go to the Farm Owner and staff affected by the event according to their responsibilities. Replaced staff may receive their replacement notice, but notification delivery does not extend their access to farm records.

**Tiếng Việt:** Thông báo vận hành được gửi cho Farm Owner và nhân sự bị ảnh hưởng theo sự kiện, trách nhiệm. Nhân sự bị thay được nhận thông báo thay thế của mình nhưng việc nhận thông báo không kéo dài quyền xem hồ sơ trại.

### BR-146

**English:** Notifications cover staff activation, assignments, tasks, protocol decisions, disease cases, water and inventory alerts, treatment changes, seasons and harvests. Schedule due, overdue, completion, cancellation and generation failure also notify the affected users; processing the same event again must not duplicate a recipient's notification.

**Tiếng Việt:** Thông báo bao gồm kích hoạt nhân sự, phân công, công việc, duyệt phác đồ, ca bệnh, cảnh báo nước và kho, thay đổi điều trị, vụ và thu hoạch. Lịch đến hạn, quá hạn, hoàn thành, bị hủy và lỗi sinh lịch cũng phải báo cho người bị ảnh hưởng; xử lý lại cùng sự kiện không được gửi trùng cho cùng người nhận.

### BR-147

**English:** An account may read and mark only its own notifications as read. The first-read time is recorded once; marking all as read does not delete notifications.

**Tiếng Việt:** Tài khoản chỉ được xem và đánh dấu đã đọc thông báo của mình. Thời điểm đọc đầu tiên chỉ ghi một lần; đánh dấu tất cả đã đọc không xóa thông báo.

### BR-148

**English:** A notification link does not grant access to its target. Opening it must satisfy the account's current ownership, assignment or permitted historical access to that resource.

**Tiếng Việt:** Liên kết thông báo không tự cấp quyền vào nội dung đích. Khi mở vẫn phải đáp ứng quyền sở hữu, phân công hiện tại hoặc quyền xem lịch sử được phép đối với nội dung đó.

## 20. AI

### BR-149

**English:** Disease-sign detection requires at least one shrimp image and may be requested only by the current Technician of an ACTIVE season. Each request retains its inputs and either its result or failure information, together with the available model and processing details.

**Tiếng Việt:** Nhận diện dấu hiệu bệnh cần ít nhất một ảnh tôm và chỉ KTV đương nhiệm của vụ ACTIVE được yêu cầu. Mỗi yêu cầu lưu đầu vào, kết quả hoặc thông tin lỗi cùng thông tin mô hình và xử lý có được.

### BR-150

**English:** AI results are advisory and cannot create, resolve or change a disease case automatically. Only the Technician may manually link their result to a case in the same season.

**Tiếng Việt:** Kết quả AI chỉ mang tính tham khảo, không tự tạo, kết luận hoặc đổi trạng thái ca bệnh. Chỉ KTV được chủ động gắn kết quả của mình vào ca thuộc cùng vụ.

### BR-151

**English:** Detection uses four labels: Healthy, BG, WSSV and WSSV_BG. Confidence below 80% produces an UNRECOGNIZED result without presenting a disease label as identified; this recognition result is separate from technical processing success or failure.

**Tiếng Việt:** Nhận diện dùng bốn nhãn: Healthy, BG, WSSV và WSSV_BG. Độ tin cậy dưới 80% cho kết quả UNRECOGNIZED, không trình bày nhãn bệnh như đã nhận diện; kết quả nhận diện này tách biệt với việc xử lý kỹ thuật thành công hay thất bại.

### BR-152

**English:** Confidence represents only the model's confidence, not clinical accuracy or a confirmed diagnosis. The four-class model is not a shrimp-species detector.

**Tiếng Việt:** Độ tin cậy chỉ thể hiện mức tin cậy của mô hình, không phải độ chính xác lâm sàng hay chẩn đoán xác nhận. Mô hình bốn lớp không phải công cụ nhận diện loài tôm.

### BR-153

**English:** A Technician may view only their own AI requests for seasons they are authorized to access. Replacement does not transfer the previous Technician's private AI history to the replacement.

**Tiếng Việt:** KTV chỉ được xem yêu cầu AI của mình trong các vụ mình có quyền truy cập. Thay KTV không chuyển lịch sử AI riêng của người trước sang người thay thế.

## 21. RAG

### BR-154

**English:** Each chatbot conversation belongs to one Technician and one assigned season. Only its owner may view it; new questions require an ACTIVE Technician with a current assignment to a season that is not COMPLETED or CANCELLED.

**Tiếng Việt:** Mỗi cuộc trò chuyện chatbot thuộc một KTV và một vụ được phân công. Chỉ chủ cuộc trò chuyện được xem; hỏi mới cần KTV ACTIVE đang được phân công vào vụ chưa COMPLETED hoặc CANCELLED.

### BR-155

**English:** Each chatbot response is classified as ANSWERED, NO_SOURCE, LOW_MATCH or ERROR. An ANSWERED result requires an answer, an ERROR result requires failure information, and answers with missing or weak sources must clearly identify that limitation.

**Tiếng Việt:** Mỗi phản hồi chatbot được phân loại ANSWERED, NO_SOURCE, LOW_MATCH hoặc ERROR. ANSWERED phải có câu trả lời, ERROR phải có thông tin lỗi; câu trả lời thiếu nguồn hoặc nguồn ít phù hợp phải thể hiện rõ hạn chế đó.

### BR-156

**English:** An ACTIVE Technician may rate a non-empty, non-error chatbot answer they own from one to five stars, with an optional comment. Each question has at most one feedback entry, which the owner may update.

**Tiếng Việt:** KTV ACTIVE được chấm câu trả lời chatbot của mình có nội dung và không phải lỗi từ một đến năm sao, kèm bình luận tùy chọn. Mỗi câu hỏi có tối đa một phản hồi đánh giá và chủ phản hồi được cập nhật.

### BR-157

**English:** The chatbot provides advice only. It cannot execute operations, approve protocols, change season or case states, or replace the Expert's decisions.

**Tiếng Việt:** Chatbot chỉ tư vấn. Chatbot không được thực hiện vận hành, duyệt phác đồ, đổi trạng thái vụ hoặc ca bệnh, hay thay quyết định của Expert.

### BR-158

**English:** Only READY and active knowledge documents may be retrieved as chatbot sources. An empty source set or an unsupported answer cannot be presented as verified knowledge.

**Tiếng Việt:** Chỉ tài liệu tri thức READY và đang bật được truy hồi làm nguồn chatbot. Tập nguồn trống hoặc câu trả lời không có căn cứ không được trình bày như tri thức đã kiểm chứng.

## 22. KDM

### BR-159

**English:** Only Admin may upload and manage knowledge documents. Accepted files are PDF, DOCX, TXT and MD, up to 10 MB, with a title and category; categories are Cultivation techniques, Shrimp diseases and Other.

**Tiếng Việt:** Chỉ Admin được tải lên và quản lý tài liệu tri thức. Hệ thống nhận PDF, DOCX, TXT và MD, tối đa 10 MB, có tiêu đề và danh mục; các danh mục gồm Kỹ thuật nuôi, Bệnh trên tôm và Khác.

### BR-160

**English:** Documents selected and uploaded by Admin become eligible sources only after successful processing to READY and while active. No separate approval after processing is required; READY does not certify the factual accuracy of the content.

**Tiếng Việt:** Tài liệu do Admin lựa chọn và tải lên chỉ đủ điều kiện làm nguồn sau khi xử lý thành READY và đang bật. Không có bước duyệt riêng sau xử lý; READY không chứng nhận nội dung chính xác về chuyên môn.

### BR-161

**English:** Editing a document's title, description or category does not replace its file, processed content or processing status.

**Tiếng Việt:** Sửa tiêu đề, mô tả hoặc danh mục tài liệu không thay tệp, nội dung đã xử lý hoặc trạng thái xử lý.

### BR-162

**English:** Admin may switch a READY document on or off. A switched-off document is excluded from new retrievals but the document and previous conversation history are retained.

**Tiếng Việt:** Admin được bật hoặc tắt tài liệu READY. Tài liệu đã tắt bị loại khỏi các lần truy hồi mới nhưng tài liệu và lịch sử hội thoại trước đó được giữ nguyên.

### BR-163

**English:** Admin may retry processing a failed document using its original file. Retry updates the same document rather than creating a second document.

**Tiếng Việt:** Admin được xử lý lại tài liệu thất bại bằng tệp gốc. Xử lý lại cập nhật chính tài liệu đó, không tạo tài liệu thứ hai.

### BR-164

**English:** Re-upload is allowed only to restore the original file of a failed document when that file is missing. The restored file must match the original file's identity; after successful reprocessing, only the new processed version is eligible for retrieval.

**Tiếng Việt:** Chỉ được tải lại để khôi phục tệp gốc bị mất của tài liệu xử lý thất bại. Tệp khôi phục phải đúng tệp gốc; sau khi xử lý lại thành công, chỉ phiên bản đã xử lý mới được dùng truy hồi.

### BR-165

**English:** A document's usage count is the number of ANSWERED chatbot answers that cite it. Each answer counts at most once for each cited document, regardless of how many passages from that document are cited.

**Tiếng Việt:** Số lượt sử dụng tài liệu là số câu trả lời chatbot ANSWERED có trích dẫn tài liệu đó. Mỗi câu trả lời chỉ tính tối đa một lượt cho mỗi tài liệu được trích dẫn, dù dùng nhiều đoạn của cùng tài liệu.

## 23. DASHBOARD

### BR-166

**English:** Dashboard indicators summarize recorded data within the viewer's authorized scope and selected period. They do not automatically score or rank staff performance.

**Tiếng Việt:** Chỉ số tổng quan tổng hợp dữ liệu đã ghi nhận trong phạm vi người xem được phép và kỳ được chọn. Các chỉ số không tự chấm điểm hoặc xếp hạng nhân sự.

### BR-167

**English:** Staff participation indicators include current and historical assignments. Farm Owner overview counts distinguish active farms, working ponds and ACTIVE seasons from inactive or ended records.

**Tiếng Việt:** Chỉ số tham gia của nhân sự tính cả phân công hiện tại và trước đây. Tổng quan Farm Owner phân biệt trại đang hoạt động, ao đang sử dụng và vụ ACTIVE với các bản ghi ngừng hoạt động hoặc đã kết thúc.

### BR-168

**English:** Reported harvest revenue totals known revenues for the selected farms and period, with unpriced harvests identified separately. If all harvests are unpriced, revenue is undetermined; if there are no harvests, revenue is zero.

**Tiếng Việt:** Doanh thu thu hoạch báo cáo là tổng các khoản đã biết của trại và kỳ được chọn, thể hiện riêng các lần thu chưa có giá. Nếu mọi lần thu đều chưa có giá thì doanh thu chưa xác định; nếu không có thu hoạch thì doanh thu bằng 0.

### BR-169

**English:** A revenue total with unpriced harvests must be labelled incomplete. Any margin calculated from it must also identify that limitation.

**Tiếng Việt:** Tổng doanh thu còn các lần thu chưa có giá phải được ghi rõ là chưa đầy đủ. Chênh lệch thu chi tính từ tổng đó cũng phải thể hiện hạn chế này.

### BR-170

**English:** Material-use cost includes all product categories issued through pond-operation executions, valued at the actual receipt-layer costs and attributed to their actual execution times. Purchases and unrelated manual stock-outs are excluded; revenue minus material-use cost is a material margin, not full farm profit.

**Tiếng Việt:** Chi phí vật tư sử dụng gồm mọi nhóm vật tư xuất qua thực hiện vận hành ao, tính theo giá vốn các phần nhập thực dùng và thời điểm thực hiện thực tế. Không tính tiền mua hàng hoặc xuất thủ công không liên quan; doanh thu trừ chi phí vật tư là chênh lệch sau vật tư, không phải lợi nhuận đầy đủ của trại.
