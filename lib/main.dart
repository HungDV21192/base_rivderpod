import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_demo/app/i18n/strings.g.dart';
import 'package:riverpod_demo/app/router/app_router.dart';
import 'package:riverpod_demo/app/settings/app_settings.dart';
import 'package:riverpod_demo/app/settings/auth_status_provider.dart';
import 'package:riverpod_demo/constants/key_data.dart';
import 'package:riverpod_demo/core/storage/shared_prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // 2. Thực hiện các logic load data nặng nhất ở đây
  // Ví dụ: Load SharedPreferences, SecureStorage, Firebase...
  final  prefs = await SharedPreferences.getInstance();
  // Khởi tạo store và lấy access token nếu cần
  final storage = const FlutterSecureStorage();
  final accessToken = await storage.read(key: 'access_token');
  // Khởi tạo Slang và set language cho app
  final langCode = prefs.getString(KeyData.languageKey) ?? 'en';
  LocaleSettings.setLocaleRaw(langCode);
  // 3. Khởi chạy App và Inject dữ liệu vào Riverpod
  runApp(
    ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          authStatusProvider.overrideWith(() => AuthStatus()..init(accessToken != null)),
        ],
        child: TranslationProvider(
      child: const MyApp(),
    )),
  );
  // 4. SAU KHI runApp đã render khung hình đầu tiên, ta mới tắt Splash
  FlutterNativeSplash.remove();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final translationLocale = TranslationProvider.of(context).flutterLocale;
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      locale: translationLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: settings.themeMode,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue, brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // Ẩn bàn phím khi chạm vào bất kỳ vùng trống nào trong app
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child,
        );
      },
    );
  }
}
