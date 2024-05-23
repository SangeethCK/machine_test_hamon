import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/applications/class_room/class_room_state.dart';
import 'package:machine_test/domain/models/class_room/update_classroom_subject_request.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/infrastructure/class_room/class_room_repostory.dart';

part 'class_room_event.dart';

class ClassRoomBloc extends Bloc<ClassRoomEvent, ClassRoomState> {
  ClassRoomBloc() : super(ClassRoomInitial()) {
    on<ClassRoomloaded>(_onLoadClassRoom);
    on<ClassRoomDetailEvent>(_onLoadStudentDetails);
    on<UpdateSubjectEvent>(_onUpdateClassRoomSubject);
    on<UpdateSelectedSubjectEvent>(_onUpdateSelectedSubject);
    on<UpdateSelectedStudentEvent>(_onUpdateSelectedStudent);
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
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
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
    emit(state.copyWith(selectedSubjectName: event.selectedSubjectName));
  }

  Future<void> _onUpdateSelectedStudent(
      UpdateSelectedStudentEvent event, Emitter<ClassRoomState> emit) async {
    emit(state.copyWith(selectedStudentName: event.selectedStudentName));
  }
}
