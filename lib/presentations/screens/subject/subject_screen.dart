import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/subject/subject_bloc.dart';
import 'package:machine_test/applications/subject/subject_state.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';
import 'package:machine_test/presentations/screens/subject/widgets/subject_details.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key, this.isValue = false, this.id});
  final bool isValue;
  final int? id;

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubjectBloc>().add(const SubjectLoadedEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocListener<SubjectBloc, SubjectState>(
        listener: (context, state) {
          if (state.isStatus == ApiFetchStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to load subject')),
            );
          }
        },
        child: MainPadding(
          top: 10,
          child: BlocBuilder<SubjectBloc, SubjectState>(
            builder: (context, state) {
              if (state.isStatus == ApiFetchStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.isStatus == ApiFetchStatus.success) {
                return Column(
                  children: [
                    headTitle(StringConstant.subjects),
                    10.verticalSpace,
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.subjectList?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (widget.isValue == true) {
                                Navigator.pop(context, [
                                  state.subjectList?[index].id,
                                  state.subjectList?[index].name
                                ]);
                              } else {
                                if (state.isStatus == ApiFetchStatus.success) {
                                  context.read<SubjectBloc>().add(
                                      SubjectDetailsLoadedEvent(
                                          subjectId:
                                              state.subjectList?[index].id ??
                                                  0));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SubjectDetailsScreen(
                                          id: state.subjectList?[index].id,
                                        ),
                                      ));
                                }
                              }
                            },
                            child: commonListCard(
                              title1: state.subjectList?[index].name ?? '',
                              title2: 'Credit',
                              trailingTitle1: state.subjectList?[index].teacher
                                      .toString() ??
                                  '',
                              trailingTitle2: state.subjectList?[index].credits
                                      .toString() ??
                                  '',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
