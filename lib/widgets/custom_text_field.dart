import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  const CustomTextField({
    super.key,
     this.controller,
     this.hintText,
    this.errorText,
     this.labelText,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
  }
}