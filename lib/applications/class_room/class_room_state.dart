import 'package:equatable/equatable.dart';
import 'package:machine_test/domain/models/class_room/class_room_details.dart';
import 'package:machine_test/domain/models/class_room/class_room_response.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';

class ClassRoomState extends Equatable {
  const ClassRoomState({this.classRoomList, this.isStatus, this.classDetail});

  final List<Classroom>? classRoomList;
  final ApiFetchStatus? isStatus;
  final ClassRoomDetailResponse? classDetail;
  @override
  List<Object?> get props => [classRoomList, isStatus, classDetail];
  ClassRoomState copyWith(
      {List<Classroom>? classRoomList,
      ApiFetchStatus? isStatus,
      ClassRoomDetailResponse? classDetail}) {
    return ClassRoomState(
        classRoomList: classRoomList ?? this.classRoomList,
        isStatus: isStatus ?? this.isStatus,
        classDetail: classDetail ?? this.classDetail);
  }
}

final class ClassRoomInitial extends ClassRoomState {}
