import 'package:flutter/foundation.dart';

@immutable
class SignInState {
  final String username;
  final String password;
  final bool rememberMe;
  final String? usernameError;
  final String? passwordError;
  final bool isSubmitting;

  const SignInState({
    this.username = '',
    this.password = '',
    this.rememberMe = false,
    this.usernameError,
    this.passwordError,
    this.isSubmitting = false,
  });

  bool get isValid => usernameError == null && passwordError == null && username.isNotEmpty && password.isNotEmpty;

  SignInState copyWith({
    String? username,
    String? password,
    bool? rememberMe,
    String? usernameError,
    String? passwordError,
    bool? isSubmitting,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      usernameError: usernameError,
      passwordError: passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
