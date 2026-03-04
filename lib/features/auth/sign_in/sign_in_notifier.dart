import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/constants/key_data.dart';
import 'package:riverpod_demo/core/storage/shared_prefs_provider.dart';
import 'package:riverpod_demo/features/auth/sign_in/sign_in_state.dart';
import 'package:riverpod_demo/utils/validations.dart';

part 'sign_in_notifier.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  SignInState build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final bool isRemembered = prefs.getBool(KeyData.keyRemember) ?? false;
    if (isRemembered) {
      final String user = prefs.getString(KeyData.keyUser) ?? '';
      final String pass = prefs.getString(KeyData.keyPass) ?? '';
      return SignInState(username: user, password: pass, rememberMe: true);
    }
    return const SignInState();
  }

  void onUsernameChanged(String value) {
    final error = Validations.validateUsername(value);
    state = state.copyWith(username: value, usernameError: error);
  }

  void onPasswordChanged(String value) {
    final error = Validations.validatePassword(value);
    state = state.copyWith(password: value, passwordError: error);
  }

  void toggleRememberMe(bool value) {
    state = state.copyWith(rememberMe: value);
  }

  Future<void> login() async {
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final prefs = ref.read(sharedPreferencesProvider);
    if (!state.isValid) return;
    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(seconds: 2));
    if (state.rememberMe) {
      await prefs.setString(KeyData.keyUser, state.username);
      await prefs.setString(KeyData.keyPass, state.password);
      await prefs.setBool(KeyData.keyRemember, true);
    } else {
      await prefs.clear();
    }
    state = state.copyWith(isSubmitting: false);

    // TODO: call API
  }
}
