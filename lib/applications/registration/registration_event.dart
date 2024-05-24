part of 'registration_bloc.dart';

class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class NewRegistrationEvent extends RegistrationEvent {
  const NewRegistrationEvent({this.studentId, this.subjectId,this.errorMesggae});
  final int? studentId;
  final int? subjectId;
  final String? errorMesggae;

  @override
  List<Object?> get props => [studentId, subjectId,errorMesggae];
}

class RegistrationLoaded extends RegistrationEvent {
  const RegistrationLoaded();

  @override
  List<Object?> get props => [];
}

class RegistrationDetailEvent extends RegistrationEvent {
  const RegistrationDetailEvent({this.id});
  final int? id;
  @override
  List<Object?> get props => [id];
}

class RegistrationDelete extends RegistrationEvent {
  const RegistrationDelete({this.id, this.studentId, this.subjectId});
  final int? id;
  final int? studentId;
  final int? subjectId;
  @override
  List<Object?> get props => [id, studentId, subjectId];
}
