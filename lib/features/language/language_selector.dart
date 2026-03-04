import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/app/i18n/strings.g.dart';
import 'package:riverpod_demo/app/settings/app_settings.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(appSettingsProvider.select((s) => s.locale));
    final settingsNotifier = ref.read(appSettingsProvider.notifier);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Để sheet cao vừa đủ nội dung
        children: [
           Text(t.login.select_language, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildLanguageItem(
            context: context,
            title: t.login.vietnam,
            flag: "🇻🇳",
            isSelected: currentLocale.languageCode == 'vi',
            onTap: () => settingsNotifier.changeLanguage('vi'),
          ),
          _buildLanguageItem(
            context: context,
            title: t.login.english,
            flag: "🇺🇸",
            isSelected: currentLocale.languageCode == 'en',
            onTap: () => settingsNotifier.changeLanguage('en'),
          ),
        ],
      ),
    );
  }
  Widget _buildLanguageItem({
    required BuildContext context,
    required String title,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(title),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
    );
  }
}