part of 'students_bloc.dart';

sealed class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object> get props => [];
}

final class LoadStudentsEvent extends StudentsEvent {}

class LoadStudentDetailsEvent extends StudentsEvent {
  final int studentId;

  const LoadStudentDetailsEvent(this.studentId);

  @override
  List<Object> get props => [studentId];
}
