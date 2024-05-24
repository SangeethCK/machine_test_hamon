import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/domain/models/registration/registration_detail_response.dart';
import 'package:machine_test/domain/models/registration/registration_response.dart';
import 'package:machine_test/domain/utilities/enums/api_fetch_status.dart';
import 'package:machine_test/infrastructure/registration/registration_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<NewRegistrationEvent>(_onUpdateClassRoomSubject);
    on<RegistrationLoaded>(_onLoadRegistrtaion);
    on<RegistrationDetailEvent>(_onLoadRegistrtaionDetail);
    on<RegistrationDelete>(_onRegistrationDelete);
  }
//=-=-=-=-= Registration Creation =-=-=-==-=

  Future<void> _onUpdateClassRoomSubject(
      NewRegistrationEvent event, Emitter<RegistrationState> emit) async {
    try {
      final registrationResponse = await RegistrationRepository()
          .createRegistration(event.studentId ?? 0, event.subjectId ?? 0);
      final registration = Registration(
        id: registrationResponse.registration?.id,
        student: registrationResponse.registration?.student,
        subject: registrationResponse.registration?.subject,
      );
      final List<Registration>? currentList = state.registrationList;
      final List<Registration> updatedList = [
        ...currentList ?? [],
        registration
      ];

      emit(state.copyWith(
          registrationList: updatedList, isStatus: ApiFetchStatus.success));
    } on ConflictException catch (e) {
      emit(state.copyWith(
          isStatus: ApiFetchStatus.failed, errorMessgae: e.message.toString()));
    }
  }
//=-=-=-=-= Registration Loaded =-=-=-==-=

  Future<void> _onLoadRegistrtaion(
      RegistrationLoaded event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));

    log("${state.isStatus}");
    try {
      final regiList = await RegistrationRepository().loadRegistration();

      emit(state.copyWith(
          isStatus: ApiFetchStatus.success, registrationList: regiList));
    } catch (e) {
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
    }
  }
//=-=-=-=-= Registration Details =-=-=-==-=

  Future<void> _onLoadRegistrtaionDetail(
      RegistrationDetailEvent event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(isStatus: ApiFetchStatus.loading));

    log("${state.isStatus}");
    try {
      final regDetail =
          await RegistrationRepository().loadRegistrationDetail(event.id ?? 0);

      emit(state.copyWith(
          isStatus: ApiFetchStatus.success, regDetail: regDetail));
    } catch (e) {
      emit(state.copyWith(isStatus: ApiFetchStatus.failed));
    }
  }

//=-=-=-=-= Registration Deleted =-=-=-==-=
  Future<void> _onRegistrationDelete(
      RegistrationDelete event, Emitter<RegistrationState> emit) async {
    try {
      final message = await RegistrationRepository().loadRegistrationDelete(
          id: event.id,
          studentId: event.studentId ?? 0,
          subjectId: event.subjectId ?? 0);

      final updatedList = state.registrationList
          ?.where((registration) => registration.id != event.id)
          .toList();
      emit(state.copyWith(
        isStatus: ApiFetchStatus.success,
        deletionStatus: DeletionStatus.success,
        deletionMessage: message,
        registrationList: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(
        isStatus: ApiFetchStatus.failed,
        deletionStatus: DeletionStatus.failure,
        deletionMessage: 'Error deleting registration',
      ));
    }
  }
}
