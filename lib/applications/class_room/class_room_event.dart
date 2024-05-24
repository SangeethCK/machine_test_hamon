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
  final int? selectedSubjectId;
  final String selectedSubjectName;
  final String? selectedPersonName;

  const UpdateSelectedSubjectEvent(this.selectedSubjectId,
      this.selectedSubjectName, this.selectedPersonName);

  @override
  List<Object?> get props =>
      [selectedSubjectName, selectedSubjectId, selectedPersonName];
}

class UpdateSelectedStudentEvent extends ClassRoomEvent {
  final String selectedStudentName;
  final int selectedStudentId;

  const UpdateSelectedStudentEvent(
      this.selectedStudentName, this.selectedStudentId);

  @override
  List<Object?> get props => [selectedStudentName, selectedStudentId];
}

class ClearClassRoomStateEvent extends ClassRoomEvent {}

// class ClearSelectedSubjectName extends ClassRoomEvent {}

class ClearSelectedStudentName extends ClassRoomEvent {}

class ClearSelectedSubjectEvent extends ClassRoomEvent {}
