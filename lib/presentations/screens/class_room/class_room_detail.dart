import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/applications/class_room/class_room_bloc.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
import 'package:machine_test/domain/core/constant/images.dart';
import 'package:machine_test/domain/models/class_room/update_classroom_subject_request.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/presentations/screens/subject/subject_screen.dart';
import 'package:machine_test/presentations/widgets/appbar/appbar.dart';
import 'package:machine_test/presentations/widgets/button/common_buttons.dart';

class ClassRoomDetailScreen extends StatelessWidget {
  const ClassRoomDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: BlocBuilder<ClassRoomBloc, ClassRoomState>(
        builder: (context, state) {
          return state.isStatus == ApiFetchStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : PopScope(
                  onPopInvoked: (didPop) {
                    _performAsyncOperations(true, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          state.classDetail?.name ?? '',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<ClassRoomBloc, ClassRoomState>(
                          builder: (context, state) {
                            return CommonLightCard(
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
                                      UpdateSelectedSubjectEvent(
                                          selectedId.last, selectedId.first));
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

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('SuccessFully Updated')),
                                    );
                                  });
                                }
                              },
                            );
                          },
                        ),
                        30.verticalSpace,
                        Expanded(
                          child: BlocBuilder<ClassRoomBloc, ClassRoomState>(
                            builder: (context, state) {
                              if (state.isStatus == ApiFetchStatus.loading) {
                                const CircularProgressIndicator();
                              } else {
                                return GridView.builder(
                                  itemCount: state.classDetail?.size ?? 0,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: kBlack),
                                      ),
                                      child:
                                          Image.asset(Assets.sitingChairLeft),
                                    );
                                  },
                                );
                              }
                              return const Text('Error');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Future<void> _performAsyncOperations(bool completion, context) async {
    try {
      await context.read<ClassRoomBloc>().add(const ClassRoomSubjectDetail());
      await context.read<ClassRoomBloc>().add(ClearSelectedSubjectName());
      // await context.watch<ClassRoomBloc>().add(ClearClassEvent());

      completion = true;
    } catch (e) {
      completion = false;
    }
  }
}
