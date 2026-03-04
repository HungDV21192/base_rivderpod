import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_status_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthStatus extends _$AuthStatus {
  bool _initialValue = true;

  @override
  bool build() => _initialValue; // Giá trị mặc định
  // Tạo hàm này để có thể gọi từ Dio client
  void init(bool value) {
    _initialValue = value;
  }

  void updateStatus(bool value) => state = value;
}
