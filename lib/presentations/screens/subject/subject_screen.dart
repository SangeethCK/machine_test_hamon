import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/subject/subject_bloc.dart';
import 'package:machine_test/applications/subject/subject_state.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/helper.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/routes/routes.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';
import 'package:machine_test/presentations/widgets/snackbars/snackbar.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key, this.isValue = false});
  final bool isValue;

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
                commonSnackBar(message: StringConstant.failedSubject));
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
                                log("Id can change your life ==-=-= ${state.subjectList?[index].id}");
                                Navigator.pop(context, [
                                  state.subjectList?[index].id,
                                  state.subjectList?[index].name,
                                  state.subjectList?[index].teacher,
                                ]);
                              } else {
                                if (state.isStatus == ApiFetchStatus.success) {
                                  context.read<SubjectBloc>().add(
                                      SubjectDetailsLoadedEvent(
                                          subjectId:
                                              state.subjectList?[index].id ??
                                                  0));

                                  Navigator.pushNamed(context, subjectDetail);
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
                return Center(child: Text(StringConstant.failedSubject));
              }
              return Center(
                child: Text(StringConstant.loadedSubject),
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
