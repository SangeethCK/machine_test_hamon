import 'package:flutter/material.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';

SnackBar commonSnackBar(
    {String? message, Color? backgroundColor, Color? textColor}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: backgroundColor ?? kFillLight1Color,
    behavior: SnackBarBehavior.floating,
    content: Text(
      message ?? 'Registration Successful!',
      style: FontPalette.heading6.copyWith(color: textColor ?? kGreenColor),
    ),
  );
}
