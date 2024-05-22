part of 'students_bloc.dart';

class StudentsState extends Equatable {
  const StudentsState({this.students, this.studentDetail, this.getStatus});

  final List<StudentList>? students;
  final StudentDetailResponse? studentDetail;
  final ApiFetchStatus? getStatus;
  @override
  List<Object?> get props => [students, studentDetail, getStatus];

  StudentsState copyWith({
    final List<StudentList>? students,
    final StudentDetailResponse? studentDetail,
    final ApiFetchStatus? getStatus,
  }) {
    return StudentsState(
        students: students ?? this.students,
        studentDetail: studentDetail ?? this.studentDetail,
        getStatus: getStatus ?? this.getStatus);
  }
}

final class StudentsInitial extends StudentsState {}
