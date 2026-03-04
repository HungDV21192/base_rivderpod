import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'counter_provier.g.dart';
@riverpod
class CounterMode extends _$CounterMode {
  @override
  int build() {
    // Đây là phương thức bắt buộc phải có
    return 0; // Trả về giá trị khởi tạo của state
  }

  void increment() {
    if (state < 10) state++;
  }

  void decrement() {
    if (state > 0) state--;
  }

}