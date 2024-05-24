import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/applications/subject/subject_state.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/infrastructure/subject/subject_repository.dart';

part 'subject_event.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(SubjectInitial()) {
    on<SubjectLoadedEvent>(_onLoadStudents);
    on<SubjectDetailsLoadedEvent>(_onLoadStudentDetails);
  }

  Future<void> _onLoadStudents(
      SubjectLoadedEvent event, Emitter<SubjectState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));

    log("${state.isStatus}");
    final subjectEither = await SubjectRepository().loadSubjectList();

    subjectEither.fold(
      (exception) {
        emit(state.copyWith(isStatus: ApiFetchStatus.failed));
      },
      (subjectList) {
        emit(state.copyWith(
            isStatus: ApiFetchStatus.success, subjectList: subjectList));
      },
    );
  }

  Future<void> _onLoadStudentDetails(
      SubjectDetailsLoadedEvent event, Emitter<SubjectState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));
    final detailEither =
        await SubjectRepository().loadSubjectDetails(event.subjectId);

    detailEither.fold(
      (exception) {
        emit(state.copyWith(isStatus: ApiFetchStatus.failed));
      },
      (subjectDetail) {
        emit(state.copyWith(
            subjectDetails: subjectDetail, isStatus: ApiFetchStatus.success));
      },
    );
  }
}
