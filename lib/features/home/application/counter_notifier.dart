import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_notifier.g.dart';

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  Future<int> build() async {
    await Future.delayed(const Duration(seconds: 2));
    return 0;
  }
  void increment() async {
    try {
      final currentValue = state.valueOrNull ?? 0;

      // Giả lập một tác vụ mạng khi cộng số
      state = const AsyncLoading();
      await Future.delayed(const Duration(seconds: 1));

      // FAKE LỖI: Nếu số lên đến 5 thì "văng" lỗi
      if (currentValue + 1 == 5) {
        throw Exception("Số 5 là số xui xẻo, không cho tăng!");
      }

      state = AsyncData(currentValue + 1);
    } catch (e, stack) {
      print('xem co nahy vao day ko');
      // Đẩy lỗi vào state để UI hiển thị phần error: (...)
      state = AsyncError(e, stack);
    }
  }

  void decrement() {
    final currentValue = state.valueOrNull ?? 0;
    if (currentValue > 0) {
      state = AsyncData(currentValue - 1);
    }
  }
}