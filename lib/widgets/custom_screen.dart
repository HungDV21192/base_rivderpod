import 'package:flutter/material.dart';
import 'package:riverpod_demo/constants/text_styles.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({
    super.key,
    this.titleAppBar,
    this.isCenter = true,
    this.hasAppBar = true,
    this.leading,
    this.action,
    required this.body,
  });

  final String? titleAppBar;
  final bool isCenter;
  final bool hasAppBar;
  final Widget? leading;
  final List<Widget>? action;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hasAppBar
          ? AppBar(
              actions: action,
              leading: leading,
              centerTitle: isCenter,
              title: (titleAppBar ?? '').isNotEmpty ? Text(titleAppBar!, style: TextStyles.style700(size: 20)) : null,
            )
          : null,
      body: body,
    );
  }
}
