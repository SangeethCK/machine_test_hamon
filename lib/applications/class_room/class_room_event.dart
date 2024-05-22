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
