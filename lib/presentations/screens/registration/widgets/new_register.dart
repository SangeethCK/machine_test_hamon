import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';
import 'package:machine_test/presentations/screens/subject/subject_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';

class NewRegisterScreen extends StatelessWidget {
  const NewRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: MainPadding(
        child: Column(
          children: [
            headTitle(StringConstant.newRegistration),
            20.verticalSpace,
            InkWell(
              onTap: () async {
                final selectedId = await Navigator.push<List>(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SubjectScreen(
                        isValue: true,
                      );
                    },
                  ),
                );

                if (selectedId != null) {
                  context
                      .read<ClassRoomBloc>()
                      .add(UpdateSelectedSubjectEvent(selectedId.last));
                }
                log("Id  ${selectedId?.last}");
              },
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                height: 66.sp,
                width: 356.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kFillDark1Color),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ClassRoomBloc, ClassRoomState>(
                      builder: (context, state) {
                        return Text(
                            state.selectedSubjectName ?? 'Select a subject');
                      },
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black87,
                        ))
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            InkWell(
              onTap: () async {
                final selectedId = await Navigator.push<List>(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const StudentScreen(
                        isStudent: true,
                      );
                    },
                  ),
                );

                if (selectedId != null) {
                  context
                      .read<ClassRoomBloc>()
                      .add(UpdateSelectedStudentEvent(selectedId.last));
                }
              },
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                height: 66.sp,
                width: 356.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kFillDark1Color),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ClassRoomBloc, ClassRoomState>(
                      builder: (context, state) {
                        return Text(
                            state.selectedStudentName ?? 'Select a Student');
                      },
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black87,
                        )),
                  ],
                ),
              ),
            ),
            35.verticalSpace,
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: kGreenColor, borderRadius: BorderRadius.circular(8)),
                height: 39.sp,
                width: 86.sp,
                child: Center(
                    child: Text(
                  StringConstant.add,
                  style: FontPalette.labelText2.copyWith(color: kWhite),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
