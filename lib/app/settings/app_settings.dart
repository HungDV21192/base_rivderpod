import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/app/i18n/strings.g.dart';
import 'package:riverpod_demo/constants/key_data.dart';
import 'package:riverpod_demo/core/storage/shared_prefs_provider.dart';
part 'app_settings.g.dart';

class AppSettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  AppSettingsState({required this.themeMode, required this.locale});
}

@riverpod
class AppSettings extends _$AppSettings {
  // late SharedPreferences _prefs;
  // void setPrefs(SharedPreferences sharedPrefs) {
  //   _prefs = sharedPrefs;
  // }

  @override
  AppSettingsState build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final themeStr = prefs.getString(KeyData.themeModeKey) ?? ThemeMode.light;
    final languageCode = prefs.getString(KeyData.languageKey) ?? 'en';
    return AppSettingsState(
      themeMode: ThemeMode.values.firstWhere((e) => e.name == themeStr, orElse: () => ThemeMode.system),
      locale: Locale(languageCode),
    );
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    final prefs = ref.read(sharedPreferencesProvider);
    state = AppSettingsState(themeMode: mode, locale: state.locale);
    try {
      await prefs.setString(KeyData.themeModeKey, mode.name);
    } catch (e) {
      debugPrint("Lỗi lưu theme: $e");
    }
  }

  Future<void> changeLanguage(String langCode) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(KeyData.languageKey, langCode);
    // Cập nhật Locale cho Slang (Global)
    final locale = AppLocaleUtils.parse(langCode);
    LocaleSettings.setLocale(locale);
    state = AppSettingsState(themeMode: state.themeMode, locale: Locale(langCode));
  }
}
