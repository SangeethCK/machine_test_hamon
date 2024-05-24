import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/domain/core/constant/helper.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/presentations/screens/class_room/class_room_detail_screen.dart';
import 'package:machine_test/presentations/screens/class_room/conference_room_detail.dart';
import 'package:machine_test/presentations/screens/subject/subject_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/padding/main_padding.dart';
import 'package:machine_test/presentations/widgets/snackbars/snackbar.dart';

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
                commonSnackBar(message: StringConstant.failedSubject));
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
                                  context
                                      .read<ClassRoomBloc>()
                                      .add(ClearSelectedSubjectEvent());
                                  context.read<ClassRoomBloc>().add(
                                      ClassRoomDetailEvent(
                                          classId: data?.id ?? 0));

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ConferenceRoomDetailScreen(),
                                      ));
                                } else {
                                  context
                                      .read<ClassRoomBloc>()
                                      .add(ClearSelectedSubjectEvent());

                                  context.read<ClassRoomBloc>().add(
                                      ClassRoomDetailEvent(
                                          classId: data?.id ?? 0));

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
                              trailingTitle2: StringConstant.seat,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (state.isStatus == ApiFetchStatus.failed) {
                return Center(child: Text(StringConstant.classRoomCheck));
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
