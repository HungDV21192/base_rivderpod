import 'package:flutter/material.dart';
import 'package:riverpod_demo/constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  const CustomButton({super.key, required this.text, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        disabledBackgroundColor: isLoading  ? Colors.blueAccent : Colors.grey,
        backgroundColor: onPressed != null  ? Colors.blueAccent : Colors.grey,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
            )
          : Text(text, style: TextStyles.style700(color: onPressed == null ? Colors.black : Colors.white)),
    );
  }
}
