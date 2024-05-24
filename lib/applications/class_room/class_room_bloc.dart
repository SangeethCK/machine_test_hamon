import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/domain/models/class_room/class_room_details.dart';
import 'package:machine_test/domain/models/class_room/update_classroom_subject_request.dart';
import 'package:machine_test/domain/models/subject/subject_response.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/infrastructure/class_room/class_room_repostory.dart';
import 'package:machine_test/infrastructure/subject/subject_repository.dart';

part 'class_room_event.dart';

class ClassRoomBloc extends Bloc<ClassRoomEvent, ClassRoomState> {
  ClassRoomBloc() : super(ClassRoomInitial()) {
    on<ClassRoomloaded>(_onLoadClassRoom);
    on<ClassRoomDetailEvent>(_onLoadStudentDetails);
    on<UpdateSubjectEvent>(_onUpdateClassRoomSubject);
    on<UpdateSelectedSubjectEvent>(_onUpdateSelectedSubject);
    on<UpdateSelectedStudentEvent>(_onUpdateSelectedStudent);
    on<ClearClassRoomStateEvent>(_onClearClassRoomState);
    on<ClearSelectedSubjectEvent>(_onClearSelectedSubject);
  }

//=-=-=-==-= Class Room Loaded =-=-=-=-=
  Future<void> _onLoadClassRoom(
      ClassRoomloaded event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));

    log("${state.isStatus}");
    try {
      final result = await ClassRoomRepostory().loadClassRoom();
      result.fold(
        (exception) => emit(state.copyWith(isStatus: ApiFetchStatus.failed)),
        (classRooms) => emit(
          state.copyWith(
            isStatus: ApiFetchStatus.success,
            classRoomList: classRooms,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
    }
  }
//=-=-=-==-= Class Room Detail =-=-=-=-=

  Future<void> _onLoadStudentDetails(
      ClassRoomDetailEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));
    try {
      final subjectResult = await SubjectRepository().loadSubjectList();
      final classRoomDetailResult =
          await ClassRoomRepostory().loadClassRoomDetail(event.classId ?? 0);

      subjectResult.fold(
        (exception) => emit(state.copyWith(
          classDetail: null,
          isStatus: ApiFetchStatus.failed,
        )),
        (subjects) {
          final selectedSubject = subjects.firstWhere(
            (e) =>
                e.id ==
                int.parse(classRoomDetailResult
                        .getOrElse(() => ClassRoomDetailResponse())
                        .subject ??
                    ''),
            orElse: () => SubjectList(),
          );
          emit(state.copyWith(
            selectedTeacherName: selectedSubject.teacher,
            selectedSubjectName: selectedSubject.name ?? '',
            subjectId: selectedSubject.id ?? 0,
            classDetail: classRoomDetailResult
                .getOrElse(() => ClassRoomDetailResponse()),
            isStatus: ApiFetchStatus.success,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        classDetail: null,
        isStatus: ApiFetchStatus.failed,
      ));
    }
  }
//=-=-=-==-= Class Room Update =-=-=-=-=

  Future<void> _onUpdateClassRoomSubject(
      UpdateSubjectEvent event, Emitter<ClassRoomState> emit) async {
    try {
      final result = await ClassRoomRepostory().updateClassRoomSubject(
        event.classId,
        event.updateRequest ?? UpdateSubjectRequest(),
      );
      result.fold(
        (exception) => emit(state.copyWith(isStatus: ApiFetchStatus.failed)),
        (updatedData) => emit(
          state.copyWith(
            updateSubjectRequest: updatedData,
            isStatus: ApiFetchStatus.success,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
    }
  }
//=-=-=-==-= Class Room Subject Selected =-=-=-=-=

  Future<void> _onUpdateSelectedSubject(
      UpdateSelectedSubjectEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(
        selectedSubjectName: event.selectedSubjectName,
        subjectId: event.selectedSubjectId,
        selectedTeacherName: event.selectedPersonName));
  }
//=-=-=-==-= Class Room Student =-=-=-=-=

  Future<void> _onUpdateSelectedStudent(
      UpdateSelectedStudentEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(
      selectedStudentName: event.selectedStudentName,
      studentId: event.selectedStudentId,
    ));
  }
//=-=-=-==-= Clear State =-=-=-=-=

  Future<void> _onClearClassRoomState(
      ClearClassRoomStateEvent event, Emitter<ClassRoomState> emit) async {
    emit(ClassRoomInitial());
  }

  Future<void> _onClearSelectedSubject(
      ClearSelectedSubjectEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(
      selectedSubjectName: null,
      subjectId: null,
      selectedTeacherName: null,
    ));
  }

  @override
  void onChange(Change<ClassRoomState> change) {
    super.onChange(change);
    log(change.currentState.selectedStudentName.toString());
  }

  @override
  void onTransition(Transition<ClassRoomEvent, ClassRoomState> transition) {
    super.onTransition(transition);
    log('[${transition.runtimeType}]  transition: ${transition.event} ');
    log('[${transition.runtimeType}]  currentstate: ${transition.currentState.selectedSubjectName} ');
    log('[${transition.runtimeType}]  nextState: ${transition.nextState.selectedSubjectName} ');
  }
}
