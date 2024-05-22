import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/domain/models/student/student_details.dart';
import 'package:machine_test/domain/models/student/student_response.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/infrastructure/students/students_repository.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc() : super(StudentsInitial()) {
    on<LoadStudentsEvent>(_onLoadStudents);
    on<LoadStudentDetailsEvent>(_onLoadStudentDetails);
  }
//=-=-=-= Students =-=-=-=-=
  Future<void> _onLoadStudents(
      LoadStudentsEvent event, Emitter<StudentsState> emit) async {
    emit(state.copyWith(getStatus: ApiFetchStatus.loading));

    log("${state.getStatus}");
    try {
      final students = await StudentsRepository().loadStudent();

      emit(state.copyWith(
          getStatus: ApiFetchStatus.success, students: students));
    } catch (e) {
      emit(state.copyWith(getStatus: ApiFetchStatus.failed));
    }
  }

  //=-=-= Student Details =-=-=-=
  Future<void> _onLoadStudentDetails(
      LoadStudentDetailsEvent event, Emitter<StudentsState> emit) async {
    emit(state.copyWith(getStatus: ApiFetchStatus.loading));
    try {
      final studentDetail =
          await StudentsRepository().loadStudentDetil(event.studentId);
      emit(state.copyWith(
          studentDetail: studentDetail, getStatus: ApiFetchStatus.success));
    } catch (e) {
      emit(state.copyWith(getStatus: ApiFetchStatus.failed));
    }
  }
}
