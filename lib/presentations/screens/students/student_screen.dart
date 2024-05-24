import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/students/students_bloc.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/helper.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/models/student/student_response.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';
import 'package:machine_test/presentations/screens/students/widgets/student_detail.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';
import 'package:machine_test/presentations/widgets/snackbars/snackbar.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key, this.isStudent});
  final bool? isStudent;

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentsBloc>().add(LoadStudentsEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocConsumer<StudentsBloc, StudentsState>(
        listener: (context, state) {
          if (state.getStatus == ApiFetchStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
              message: StringConstant.faildTostudent,
            ));
          }
        },
        builder: (context, state) {
          if (state.getStatus == ApiFetchStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.getStatus == ApiFetchStatus.success) {
            return MainPadding(
              top: 10,
              child: Column(
                children: [
                  headTitle(StringConstant.students),
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.students?.length ?? 0,
                      itemBuilder: (context, index) {
                        final student = state.students![index];
                        return InkWell(
                          onTap: () {
                            if (widget.isStudent == true) {
                              Navigator.pop(
                                  context, [student.id, student.name]);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StudentDetailScreen(id: student.id ?? 0),
                                ),
                              );
                            }
                          },
                          child: _studentsCard(student),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state.getStatus == ApiFetchStatus.failed) {
            return Center(child: Text(StringConstant.faildTostudent));
          }
          return Center(child: Text(StringConstant.pressedTheloadstudent));
        },
      ),
    );
  }
}

Widget _studentsCard(StudentList student) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    height: 60.sp,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: kFillDark1Color,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              student.name ?? '',
              style: FontPalette.labelText1,
            ),
            Text(
              student.email ?? '',
              style: FontPalette.labelLightText1,
            ),
          ],
        ),
        Text(
          "Age : ${student.age}",
          style: FontPalette.labelLightText1,
        ),
      ],
    ),
  );
}
