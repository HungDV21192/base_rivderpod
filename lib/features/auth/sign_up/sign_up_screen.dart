import 'package:flutter/material.dart';
import 'package:riverpod_demo/app/i18n/strings.g.dart';
import 'package:riverpod_demo/widgets/custom_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      titleAppBar: t.login.sign_up,
      body: Container(width: double.infinity, height: double.infinity, color: Colors.redAccent),
    );
  }
}
