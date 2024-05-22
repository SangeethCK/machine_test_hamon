import 'package:equatable/equatable.dart';
import 'package:machine_test/domain/models/subject/subject_detail_response.dart';
import 'package:machine_test/domain/models/subject/subject_response.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';

class SubjectState extends Equatable {
  const SubjectState({this.subjectList, this.isStatus, this.subjectDetails});

  final List<SubjectList>? subjectList;
  final ApiFetchStatus? isStatus;
  final SubjectDetailResponse? subjectDetails;
  @override
  List<Object?> get props => [subjectList, isStatus, subjectDetails];
  SubjectState copyWith(
      {List<SubjectList>? subjectList,
      ApiFetchStatus? isStatus,
      SubjectDetailResponse? subjectDetails}) {
    return SubjectState(
        subjectList: subjectList ?? this.subjectList,
        isStatus: isStatus ?? this.isStatus,
        subjectDetails: subjectDetails ?? this.subjectDetails);
  }
}

final class SubjectInitial extends SubjectState {}
