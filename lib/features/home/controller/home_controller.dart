// @riverpod
// class HomeController extends _$HomeController {
//   @override
//   bool build() {
//     // Khởi tạo state ban đầu
//     return false;
//   }
//
//   // Đây là nơi viết Logic, y hệt như trong GetxController
//   void toggleCheckbox() {
//     // Có thể thêm logic kiểm tra ở đây
//     // if (_vua_bam_xong_gan_day) return;
//
//     state = !state; // Cập nhật state
//   }
//
//   Future<void> submitData() async {
//     // Logic gọi API, xử lý dữ liệu phức tạp...
//     if (state == true) {
//       print("User đã đồng ý điều khoản");
//     }
//   }
// }