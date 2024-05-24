import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';

class CommonLightCard extends StatelessWidget {
  const CommonLightCard(
      {super.key, this.title, required this.onTap, this.titleAd});
  final String? title;
  final String? titleAd;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66.sp,
      width: 358.sp,
      decoration: BoxDecoration(
          color: kFillDark1Color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade300)),
      child: Center(
        child: ListTile(
          title: Text(
            title ?? StringConstant.addSubject,
            style: FontPalette.labelText3,
          ),
          trailing: InkWell(
            onTap: () async {
              onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: kFillLight1Color,
                  borderRadius: BorderRadius.circular(8)),
              height: 39.sp,
              width: 86.sp,
              child: Center(
                  child: Text(
                titleAd ?? StringConstant.add,
                style: FontPalette.labelText2.copyWith(color: kFillDark5Color),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

Widget commonButton(
    {required String title,
    Color? backgroudColor,
    Color? textColor,
    required Function onTap}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 48.sp,
      width: 177.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroudColor ?? const Color.fromRGBO(0, 122, 255, 0.15)),
      child: Center(
          child: Text(
        title,
        style: FontPalette.head5.copyWith(color: textColor ?? kBlueColor),
      )),
    ),
  );
}

Widget commonListCard({
  required String title1,
  required String title2,
  required String trailingTitle1,
  required String trailingTitle2,
  bool isFalse = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    height: 66.sp,
    width: 358.sp,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: kFillDark1Color,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title1,
              style: FontPalette.labelText1,
            ),
            Text(
              title2,
              style: FontPalette.labelLightText1,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              trailingTitle1,
              style: FontPalette.labelText1,
            ),
            Text(
              trailingTitle2,
              style: FontPalette.labelLightText1,
            ),
          ],
        ),
      ],
    ),
  );
}
