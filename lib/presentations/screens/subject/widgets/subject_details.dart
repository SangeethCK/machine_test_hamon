import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/subject/subject_bloc.dart';
import 'package:machine_test/applications/subject/subject_state.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/presentations/screens/students/student_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';

class SubjectDetailsScreen extends StatelessWidget {
  const SubjectDetailsScreen({super.key, this.id});
  final int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocBuilder<SubjectBloc, SubjectState>(
        builder: (context, state) {
          return state.isStatus == ApiFetchStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    headTitle(StringConstant.subjectDetail),
                    80.verticalSpace,
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50.sp,
                            child: Image.asset('assets/images/Ellipse 1.png'),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            state.subjectDetails?.name ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.subjectDetails?.teacher ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Credit ${state.subjectDetails?.credits ?? 0}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
