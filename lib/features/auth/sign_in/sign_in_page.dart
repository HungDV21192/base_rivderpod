import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_demo/app/i18n/strings.g.dart';
import 'package:riverpod_demo/constants/text_styles.dart';
import 'package:riverpod_demo/features/auth/sign_in/sign_in_notifier.dart';
import 'package:riverpod_demo/features/language/language_selector.dart';
import 'package:riverpod_demo/utils/app_ui.dart';
import 'package:riverpod_demo/widgets/custom_button.dart';
import 'package:riverpod_demo/widgets/custom_screen.dart';
import 'package:riverpod_demo/widgets/custom_text_field.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignInScreen> {
  late final TextEditingController _usernameCtr;
  late final TextEditingController _passwordCtr;

  @override
  void initState() {
    final initialState = ref.read(signInNotifierProvider);
    _usernameCtr = TextEditingController(text: initialState.username);
    _passwordCtr = TextEditingController(text: initialState.password);
    super.initState();
  }

  @override
  void dispose() {
    _usernameCtr.dispose();
    _passwordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signInNotifierProvider.notifier);
    final usernameError = ref.watch(signInNotifierProvider.select((s) => s.usernameError));
    final passwordError = ref.watch(signInNotifierProvider.select((s) => s.passwordError));
    final rememberMe = ref.watch(signInNotifierProvider.select((s) => s.rememberMe));
    final isSubmitting = ref.watch(signInNotifierProvider.select((s) => s.isSubmitting));
    final isButtonEnabled = ref.watch(signInNotifierProvider.select((s) => s.isValid && !s.isSubmitting));
    return CustomScreen(
      titleAppBar: t.login.title,
      action: [
        IconButton(
          onPressed: () => AppUI.showBottomSheet(context: context, child: LanguageSelector()),
          icon: Icon(Icons.language),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: _usernameCtr,
              onChanged: notifier.onUsernameChanged,
              labelText: t.login.username,
              errorText: usernameError,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordCtr,
              onChanged: notifier.onPasswordChanged,
              labelText: t.login.password,
              errorText: passwordError,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(value: rememberMe, onChanged: (v) => notifier.toggleRememberMe(v ?? false)),
                Text(t.login.remember_me),
              ],
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: t.login.button,
              isLoading: isSubmitting,
              onPressed: isButtonEnabled ? notifier.login : null,
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: t.login.has_account,
                style: TextStyles.style600(color: Colors.grey),
                children: [
                  WidgetSpan(child: SizedBox(width: 8)),
                  TextSpan(
                    text: t.login.sign_up,
                    style: TextStyles.style600(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                      style: FontStyle.italic,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.push('/sign_up');
                      },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
