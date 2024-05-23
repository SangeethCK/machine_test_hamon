part of 'class_room_bloc.dart';

class ClassRoomEvent extends Equatable {
  const ClassRoomEvent();

  @override
  List<Object?> get props => [];
}

class ClassRoomloaded extends ClassRoomEvent {}

class ClassRoomDetailEvent extends ClassRoomEvent {
  const ClassRoomDetailEvent({this.classId});
  final int? classId;
  @override
  List<Object?> get props => [classId];
}

class UpdateSubjectEvent extends ClassRoomEvent {
  final UpdateSubjectRequest? updateRequest;
  final int classId;
  const UpdateSubjectEvent({
    required this.updateRequest,
    required this.classId,
  });
  @override
  List<Object?> get props => [];
}

class UpdateSelectedSubjectEvent extends ClassRoomEvent {
  final String selectedSubjectName;
  final int? selectedSubjectId;

  const UpdateSelectedSubjectEvent(
      this.selectedSubjectName, this.selectedSubjectId);

  @override
  List<Object?> get props => [selectedSubjectName, selectedSubjectId];
}

class UpdateSelectedStudentEvent extends ClassRoomEvent {
  final String selectedStudentName;
  final int selectedStudentId;

  const UpdateSelectedStudentEvent(
      this.selectedStudentName, this.selectedStudentId);

  @override
  List<Object?> get props => [selectedStudentName, selectedStudentId];
}
