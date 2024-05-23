import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/class_room/class_room.dart';
import 'package:machine_test/presentations/screens/registration/widgets/new_register.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Column(
        children: [
          headTitle(StringConstant.registration),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return commonListCard(
                    title1: 'sfd',
                    title2: 'dsd',
                    trailingTitle1: 'dsd',
                    trailingTitle2: 'dsd');
              }),
          const Spacer(),
          commonButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const NewRegisterScreen();
                }));
              },
              title: StringConstant.newRegistration),
          20.verticalSpace,
        ],
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
