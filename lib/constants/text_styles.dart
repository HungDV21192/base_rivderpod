import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_demo/constants/app_color.dart';

class TextStyles {
  TextStyles._();

  static TextStyle style800({double? size, Color? color, FontStyle? style, double? height}) {
    return GoogleFonts.manrope(
      fontWeight: FontWeight.w800,
      fontSize: size ?? 16,
      color: color ?? AppColors.colorTextTitle,
      fontStyle: style,
      height: height,
    );
  }

  static TextStyle style700({double? size, Color? color, FontStyle? style, double? height}) {
    return GoogleFonts.manrope(
      fontWeight: FontWeight.w700,
      fontSize: size ?? 16,
      color: color ?? AppColors.colorTextTitle,
      fontStyle: style,
      height: height,
    );
  }

  static TextStyle style600({double? size, Color? color, FontStyle? style, TextDecoration? decoration}) {
    return GoogleFonts.manrope(
      fontSize: size ?? 14,
      color: color ?? AppColors.colorTextTitle,
      fontStyle: style,
      decoration: decoration,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle style500({double? size, Color? color, FontStyle? style}) {
    return GoogleFonts.manrope(
      fontWeight: FontWeight.w500,
      fontSize: size ?? 14,
      color: color ?? AppColors.colorTextTitle,
      fontStyle: style,
    );
  }

  static TextStyle style400({double? size, Color? color, FontStyle? style}) {
    return GoogleFonts.manrope(
      fontWeight: FontWeight.w400,
      fontSize: size ?? 14,
      color: color ?? AppColors.colorTextTitle,
      fontStyle: style,
    );
  }

  //Todo: old
  static TextStyle interSemiBold({double? size, Color? color, FontWeight? fontWeight, FontStyle? style}) {
    return GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: size ?? 18,
      color: color ?? Colors.black,
      fontStyle: style,
    );
  }

  static TextStyle interMedium({double? size, Color? color, FontWeight? fontWeight, FontStyle? style}) {
    return GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: size ?? 16,
      color: color ?? Colors.black,
      fontStyle: style,
    );
  }
}
