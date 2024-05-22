import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'Students',
            style: FontPalette.head3,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                margin: const EdgeInsets.only(
                    right: 10, left: 10, top: 10, bottom: 10),
                height: 60.sp,
                width: 358.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kFillDark1Color),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Name',
                          style: FontPalette.labelText1,
                        ),
                        Text(
                          'data',
                          style: FontPalette.labelLightText1,
                        ),
                      ],
                    ),
                    Text(
                      'Hello',
                      style: FontPalette.labelLightText1,
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
