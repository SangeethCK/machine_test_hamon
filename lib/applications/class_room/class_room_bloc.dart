import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/domain/models/class_room/class_room_details.dart';
import 'package:machine_test/domain/models/class_room/update_classroom_subject_request.dart';
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
    on<ClearSelectedSubjectName>(_onClearSelectedSubjectName);
    on<ClassRoomSubjectDetail>(_onMatchingSubjectWithId);
    on<ClearClassEvent>(_onClearSelectedDetails);
  }

  //=-=-=-= Students =-=-=-=-=
  Future<void> _onLoadClassRoom(
      ClassRoomloaded event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));

    log("${state.isStatus}");
    try {
      final classRoom = await ClassRoomRepostory().loadClassRoom();

      emit(state.copyWith(
          isStatus: ApiFetchStatus.success, classRoomList: classRoom));
    } catch (e) {
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
    }
  }

  //=-=-= ClassRoom Details =-=-=-=
  Future<void> _onLoadStudentDetails(
      ClassRoomDetailEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));
    try {
      final classRoomDetail =
          await ClassRoomRepostory().loadClassRoomDetail(event.classId ?? 0);
      emit(state.copyWith(
          classDetail: classRoomDetail, isStatus: ApiFetchStatus.success));
    } catch (e) {
      emit(state.copyWith(classDetail: null, isStatus: ApiFetchStatus.failed));
    }
  }

  //=-=-=-= Update Subject in Class Room =-=-=-=
  Future<void> _onUpdateClassRoomSubject(
      UpdateSubjectEvent event, Emitter<ClassRoomState> emit) async {
    try {
      final update = await ClassRoomRepostory().updateClassRoomSubject(
          event.classId, event.updateRequest ?? UpdateSubjectRequest());
      emit(state.copyWith(
          updateSubjectRequest: update, isStatus: ApiFetchStatus.success));
    } catch (e) {
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
    }
  }

  Future<void> _onUpdateSelectedSubject(
      UpdateSelectedSubjectEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(
        selectedSubjectName: event.selectedSubjectName,
        subjectId: event.selectedSubjectId));
  }

  Future<void> _onUpdateSelectedStudent(
      UpdateSelectedStudentEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(
        selectedStudentName: event.selectedStudentName,
        studentId: event.selectedStudentId));
  }

  Future<void> _onClearClassRoomState(
      ClearClassRoomStateEvent event, Emitter<ClassRoomState> emit) async {
    emit(ClassRoomInitial());
  }

  Future<void> _onClearSelectedSubjectName(
      ClearSelectedSubjectName event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(selectedSubjectName: ''));
  }

  Future<void> _onClearSelectedDetails(
      ClearClassEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(
        classDetail: ClassRoomDetailResponse(),
        selectedStudentName: null,
        selectedSubjectName: null,
        subjectId: null,
        isStatus: ApiFetchStatus.loading));
  }

  Future<void> _onMatchingSubjectWithId(
      ClassRoomSubjectDetail event, Emitter<ClassRoomState> emit) async {
    try {
      final subject = await SubjectRepository().loadSubjectList();
      log("Id =-= -=-  ${event.classId}");
      if (state.classDetail != null && state.classDetail!.subject != null) {
        final data = subject
            .firstWhere((e) => e.id == int.parse(state.classDetail?.subject));
        emit(state.copyWith(classDetail: null, selectedSubjectName: data.name));
      } else {
        emit(state.copyWith(selectedSubjectName: null));
      }
    } catch (e, stackTrace) {
      log("Error in _onMatchingSubjectWithId: $e\n$stackTrace");
    }
  }
}
