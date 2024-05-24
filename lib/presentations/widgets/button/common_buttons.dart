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
