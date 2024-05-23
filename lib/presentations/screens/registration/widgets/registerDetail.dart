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

class RegisterDetailScreen extends StatelessWidget {
  const RegisterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state.isStatus == ApiFetchStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.deletionStatus == DeletionStatus.success) {
            return SnackBar(
                content: Text(state.deletionMessage ?? 'successfull'));
          } else if (state.isStatus == ApiFetchStatus.failed) {
            return const Text('Please try again');
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
                          'Student Details',
                          style: FontPalette.paragraph3,
                        ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Student No',
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
                              'Subject No',
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
                        context.read<RegistrationBloc>().add(RegistrationDelete(
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
        title: const Text("Delete"),
        content: const Text("Do you want to delete"),
        actions: [
          TextButton(
            child: const Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              onTap();
              Navigator.pop(context);
              // Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
