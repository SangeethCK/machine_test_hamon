import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/registration/registration_bloc.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/decartion/decartions.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';
import 'package:machine_test/presentations/widgets/snackbars/snackbar.dart';

class RegisterDetailScreen extends StatelessWidget {
  const RegisterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state.deletionStatus == DeletionStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                message: state.deletionMessage ?? '',
                textColor: kWhite,
                backgroundColor: kRedColor));
            Navigator.pop(context);
          } else if (state.deletionStatus == DeletionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                message: state.deletionMessage ?? '',
                textColor: kWhite,
                backgroundColor: kRedColor));
          }
        },
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            if (state.isStatus == ApiFetchStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.deletionStatus == DeletionStatus.success) {
              return Center(child: Text(StringConstant.plsTryAgin));
            } else if (state.isStatus == ApiFetchStatus.failed) {
              return Text(StringConstant.plsTryAgin);
            } else {
              return MainPadding(
                child: Column(
                  children: [
                    headTitle(StringConstant.registration),
                    20.verticalSpace,
                    Container(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      height: 100.sp,
                      decoration: cardDecartion,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstant.studentDetail,
                            style: FontPalette.paragraph3,
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                StringConstant.stuentNo,
                                style: FontPalette.labelLightText1,
                              ),
                              Text(
                                state.regDetail?.student.toString() ?? '',
                                style: FontPalette.labelLightText1,
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                StringConstant.subjectNo,
                                style: FontPalette.labelLightText1,
                              ),
                              Text(
                                state.regDetail?.subject.toString() ?? '',
                                style: FontPalette.labelLightText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    commonButton(
                      textColor: kWhite,
                      backgroudColor: kRedColor,
                      onTap: () {
                        _showDeleteConfirmationDialog(context, () {
                          context
                              .read<RegistrationBloc>()
                              .add(RegistrationDelete(
                                id: state.regDetail?.id,
                                studentId: state.regDetail?.student,
                                subjectId: state.regDetail?.subject,
                              ));
                        });
                      },
                      title: StringConstant.deleteRegisrtaion,
                    ),
                    30.verticalSpace
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget commonButton({
    required String title,
    Color? backgroudColor,
    Color? textColor,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 48.sp,
        width: 177.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroudColor ?? kBlueColor,
        ),
        child: Center(
          child: Text(
            title,
            style: FontPalette.head5.copyWith(color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context, Function onTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(StringConstant.delete),
        content: Text(StringConstant.deleteQuestion),
        actions: [
          TextButton(
            child: Text(StringConstant.no),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(StringConstant.yes),
            onPressed: () {
              onTap();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
