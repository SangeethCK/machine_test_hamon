import 'package:equatable/equatable.dart';
import 'package:machine_test/domain/models/class_room/class_room_details.dart';
import 'package:machine_test/domain/models/class_room/class_room_response.dart';
import 'package:machine_test/domain/models/class_room/update_classroom_subject_request.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';

class ClassRoomState extends Equatable {
  const ClassRoomState({
    this.classRoomList,
    this.isStatus,
    this.classDetail,
    this.updateSubjectRequest,
    this.selectedSubjectName,
    this.selectedStudentName,
  });

  final List<Classroom>? classRoomList;
  final ApiFetchStatus? isStatus;
  final ClassRoomDetailResponse? classDetail;
  final UpdateSubjectRequest? updateSubjectRequest;
  final String? selectedSubjectName;
  final String? selectedStudentName;

  @override
  List<Object?> get props => [
        classRoomList,
        isStatus,
        classDetail,
        updateSubjectRequest,
        selectedSubjectName,
        selectedStudentName,
      ];
  ClassRoomState copyWith({
    List<Classroom>? classRoomList,
    ApiFetchStatus? isStatus,
    ClassRoomDetailResponse? classDetail,
    UpdateSubjectRequest? updateSubjectRequest,
    String? selectedSubjectName,
    String? selectedStudentName,
  }) {
    return ClassRoomState(
        classRoomList: classRoomList ?? this.classRoomList,
        isStatus: isStatus ?? this.isStatus,
        classDetail: classDetail ?? this.classDetail,
        updateSubjectRequest: updateSubjectRequest ?? this.updateSubjectRequest,
        selectedSubjectName: selectedSubjectName ?? this.selectedSubjectName,
        selectedStudentName: selectedStudentName ?? this.selectedStudentName);
  }
}

final class ClassRoomInitial extends ClassRoomState {}
