import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/applications/students/students_bloc.dart';
import 'package:machine_test/applications/subject/subject_state.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/infrastructure/subject/subject_repository.dart';

part 'subject_event.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(SubjectInitial()) {
    on<SubjectLoadedEvent>(_onLoadStudents);
    on<SubjectDetailsLoadedEvent>(_onLoadStudentDetails);
  }

  //=-=-=-= Subject =-=-=-=-=
  Future<void> _onLoadStudents(
      SubjectLoadedEvent event, Emitter<SubjectState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));

    log("${state.isStatus}");
    try {
      final subject = await SubjectRepository().loadSubjectList();

      emit(state.copyWith(
          isStatus: ApiFetchStatus.success, subjectList: subject));
    } catch (e) {
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
    }
  }

  //=-=-= Student Details =-=-=-=
  Future<void> _onLoadStudentDetails(
      SubjectDetailsLoadedEvent event, Emitter<SubjectState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));
    try {
      final studentDetail =
          await SubjectRepository().loadSubjectDetails(event.subjectId);
      emit(state.copyWith(
          subjectDetails: studentDetail, isStatus: ApiFetchStatus.success));
    } catch (e) {
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
    }
  }
}
