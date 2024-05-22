import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/domain/core/constant/colors.dart';

class FontPalette {
  static const themeFont = "SF Pro Text";

  static TextTheme get textDarkTheme {
    return Typography.englishLike2018.apply(
        fontSizeFactor: 0.8.sp,
        bodyColor: kWhite,
        fontFamily: FontPalette.themeFont);
  }

  static TextTheme get textLightTheme {
    return Typography.englishLike2018.apply(
        fontSizeFactor: 0.8.sp,
        bodyColor: kBlack,
        fontFamily: FontPalette.themeFont);
  }

  static TextStyle heading1 = TextStyle(
    fontSize: 64.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  static TextStyle heading2 = TextStyle(
    fontSize: 44.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  static TextStyle heading3 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  static TextStyle heading4 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  static TextStyle heading5 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  static TextStyle label = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  static TextStyle title = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  static TextStyle subTitle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  static TextStyle menuItem = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  static TextStyle input = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  static TextStyle navLink = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static TextStyle paragraph1 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static TextStyle paragraph2 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static TextStyle paragraph3 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static TextStyle description = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static TextStyle body1 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  static TextStyle body2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  static TextStyle body3 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  static TextStyle typoGraphy = TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: kBlack);

  static TextStyle head1 = TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      color: kBlack);
  static TextStyle headSub2 = TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: kBlack);

  static TextStyle labelText = TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: kBlack);
  static TextStyle head3 = TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      color: kBlack);
  static TextStyle labelText1 = TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: kBlack);
  static TextStyle labelLightText1 = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: kBlack);
}
