import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/class_room/class_room_detail.dart';
import 'package:machine_test/presentations/screens/class_room/conference_room_detail.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';

class ClassRoomScreen extends StatefulWidget {
  const ClassRoomScreen({super.key});

  @override
  State<ClassRoomScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<ClassRoomScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClassRoomBloc>().add(ClassRoomloaded());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocListener<ClassRoomBloc, ClassRoomState>(
        listener: (context, state) {
          if (state.isStatus == ApiFetchStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to load subject')),
            );
          }
        },
        child: MainPadding(
          top: 10,
          child: BlocBuilder<ClassRoomBloc, ClassRoomState>(
            builder: (context, state) {
              if (state.isStatus == ApiFetchStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.isStatus == ApiFetchStatus.success) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      headTitle(StringConstant.classRoom),
                      ListView.builder(
                        itemCount: state.classRoomList?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = state.classRoomList?[index];
                          return InkWell(
                            onTap: () {
                              if (state.isStatus == ApiFetchStatus.success) {
                                if (data?.layout == 'conference') {
                                  context.read<ClassRoomBloc>().add(
                                      ClassRoomDetailEvent(
                                          classId: data?.id ?? 0));
                                  context
                                      .read<ClassRoomBloc>()
                                      .add(ClearSelectedSubjectName());
                                  context
                                      .read<ClassRoomBloc>()
                                      .add(const ClassRoomSubjectDetail());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ConferenceRoomDetailScreen(),
                                      ));
                                } else {
                                  context.read<ClassRoomBloc>().add(
                                      ClassRoomDetailEvent(
                                          classId: data?.id ?? 0));
                                  context
                                      .read<ClassRoomBloc>()
                                      .add(ClearSelectedSubjectName());
                                  context
                                      .read<ClassRoomBloc>()
                                      .add(const ClassRoomSubjectDetail());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ClassRoomDetailScreen(),
                                      ));
                                }
                              }
                            },
                            child: commonListCard(
                              title1: data?.name ?? '',
                              title2: data?.size.toString() ?? '',
                              trailingTitle1: data?.layout.toString() ?? '',
                              trailingTitle2: 'Seats',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (state.isStatus == ApiFetchStatus.failed) {
                return const Center(child: Text('Failed to load subject'));
              }
              return const Center(
                child: Text('Press the button to load subject.'),
              );
            },
          ),
        ),
      ),
    );
  }
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
