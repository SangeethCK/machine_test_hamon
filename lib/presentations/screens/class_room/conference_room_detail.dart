import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/images.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/models/class_room/update_classroom_subject_request.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/subject/subject_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/button/common_buttons.dart';

class ConferenceRoomDetailScreen extends StatelessWidget {
  const ConferenceRoomDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocBuilder<ClassRoomBloc, ClassRoomState>(
        builder: (context, state) {
          return state.isStatus == ApiFetchStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            state.classDetail?.name ?? '',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        20.verticalSpace,
                        BlocBuilder<ClassRoomBloc, ClassRoomState>(
                          builder: (context, state) {
                            return CommonLightCard(
                              subTitle: state.selectedTeacherName ?? '',
                              titleAd: state.selectedSubjectName != null
                                  ? 'Change'
                                  : 'Add',
                              title: state.selectedSubjectName == ''
                                  ? 'Add Subject'
                                  : state.selectedSubjectName,
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
                                if (selectedId != null &&
                                    selectedId.isNotEmpty) {
                                  context.read<ClassRoomBloc>().add(
                                      UpdateSelectedSubjectEvent(selectedId[0],
                                          selectedId[1], selectedId[2]));
                                  log('message');
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    context.read<ClassRoomBloc>().add(
                                          UpdateSubjectEvent(
                                              updateRequest:
                                                  UpdateSubjectRequest(
                                                      id: state.classDetail?.id,
                                                      layout: state
                                                          .classDetail?.layout,
                                                      subject: selectedId.first,
                                                      name: state
                                                          .classDetail?.name,
                                                      size: state
                                                          .classDetail?.size),
                                              classId:
                                                  state.classDetail?.id ?? 0),
                                        );
                                  });
                                }
                              },
                            );
                          },
                        ),
                        20.verticalSpace,
                        const ClassroomLayout(),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class ClassroomLayout extends StatelessWidget {
  const ClassroomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassRoomBloc, ClassRoomState>(
      builder: (context, state) {
        int classSize = state.classDetail?.size ?? 0;

        int evenCount = (classSize / 2).floor();
        log('Even: $evenCount');

        int oddCount = (classSize / 2).ceil();
        log('Odd: $oddCount');

        List<Widget> leftChairs = List.generate(
          evenCount,
          (index) => Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              Assets.sitingChairLeft,
              height: 40,
            ),
          ),
        );

        List<Widget> rightChairs = List.generate(
          oddCount,
          (index) => Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              Assets.sitingChairRight,
              height: 40,
            ),
          ),
        );

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var chair in leftChairs) ...[
                        chair,
                        if (chair != leftChairs.last) const Spacer(),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  color: Colors.grey.shade200,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var chair in rightChairs) ...[
                        chair,
                        if (chair != rightChairs.last) const Spacer(),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget lightButton(
  String? name,
) {
  return Container(
    decoration: BoxDecoration(
        color: kFillLight1Color, borderRadius: BorderRadius.circular(8)),
    height: 39.sp,
    width: 86.sp,
    child: Center(
        child: Text(
      name ?? StringConstant.add,
      style: FontPalette.labelText2.copyWith(color: kFillDark5Color),
    )),
  );
}
