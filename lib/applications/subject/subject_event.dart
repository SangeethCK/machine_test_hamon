part of 'subject_bloc.dart';

class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object> get props => [];
}

class SubjectLoadedEvent extends SubjectEvent {
  const SubjectLoadedEvent();

  @override
  List<Object> get props => [];
}

class SubjectDetailsLoadedEvent extends SubjectEvent {
  const SubjectDetailsLoadedEvent({required this.subjectId});

  final int subjectId;

  @override
  List<Object> get props => [];
}
