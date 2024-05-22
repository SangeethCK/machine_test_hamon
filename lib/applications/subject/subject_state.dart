import 'package:equatable/equatable.dart';
import 'package:machine_test/domain/models/subject/subject_response.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';

class SubjectState extends Equatable {
  const SubjectState({this.subjectList, this.isStatus});

  final List<SubjectList>? subjectList;
  final ApiFetchStatus? isStatus;
  @override
  List<Object?> get props => [subjectList, isStatus];
  SubjectState copyWith(
      {List<SubjectList>? subjectList, ApiFetchStatus? isStatus}) {
    return SubjectState(
        subjectList: subjectList ?? this.subjectList,
        isStatus: isStatus ?? this.isStatus);
  }
}

final class SubjectInitial extends SubjectState {}
