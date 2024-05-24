part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.studentId,
    this.subjectId,
    this.isStatus,
    this.registration,
    this.registrationList,
    this.regDetail,
    this.deletionMessage,
    this.deletionStatus,
    this.errorMessgae,
  });

  final int? studentId;
  final int? subjectId;
  final ApiFetchStatus? isStatus;
  final RegistrationResponse? registration;
  final List<Registration>? registrationList;
  final RegistrationDetailsResponse? regDetail;
  final DeletionStatus? deletionStatus;
  final String? deletionMessage;
  final String? errorMessgae;

  @override
  List<Object?> get props => [
        studentId,
        subjectId,
        isStatus,
        registration,
        registrationList,
        regDetail,
        deletionStatus,
        deletionMessage,
        errorMessgae,
      ];

  RegistrationState copyWith({
    int? studentId,
    int? subjectId,
    RegistrationResponse? registration,
    ApiFetchStatus? isStatus,
    List<Registration>? registrationList,
    RegistrationDetailsResponse? regDetail,
    DeletionStatus? deletionStatus,
    String? deletionMessage,
    String? errorMessgae,
  }) {
    return RegistrationState(
        studentId: studentId ?? studentId,
        subjectId: subjectId ?? this.subjectId,
        isStatus: isStatus ?? this.isStatus,
        registration: registration ?? this.registration,
        registrationList: registrationList ?? this.registrationList,
        regDetail: regDetail ?? this.regDetail,
        deletionMessage: deletionMessage ?? this.deletionMessage,
        deletionStatus: deletionStatus ?? this.deletionStatus,
        errorMessgae: errorMessgae ?? this.errorMessgae);
  }
}

class RegistrationInitial extends RegistrationState {}
