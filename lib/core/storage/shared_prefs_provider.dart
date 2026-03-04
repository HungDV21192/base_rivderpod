import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_prefs_provider.g.dart'; // Đừng quên dòng này

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  // Chúng ta ném lỗi vì sẽ override nó ở hàm main
  throw UnimplementedError();
}