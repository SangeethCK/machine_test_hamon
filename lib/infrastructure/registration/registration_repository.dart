import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/end_points.dart';
import 'package:machine_test/domain/core/api/network/base_api.dart';
import 'package:machine_test/domain/models/registration/registration_detail_response.dart';
import 'package:machine_test/domain/models/registration/registration_response.dart';

class RegistrationRepository extends BaseApi {
  //=-=-=-=-= Registration List =-=-=-=-=
  Future<List<Registration>> loadRegistration() async {
    Response response = await get(EndPoints.registration);

    switch (response.statusCode) {
      case 200:
        return (response.data['registrations'] as List)
            .map((e) => Registration.fromJson(e))
            .toList();
      default:
        return throw Exception('Error');
    }
  }

  //=-=-=-=-= Creation Registration =-=-=-=-=
  Future<RegistrationResponse> createRegistration(
      int studentId, int subjectId) async {
    try {
      Response response = await post(
        EndPoints.registration,
        data: {
          "student": studentId,
          "subject": subjectId,
        },
      );

      log("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        return RegistrationResponse.fromJson(response.data);
      } else {
        final errorMessage = response.data['error'];
        throw ConflictException(errorMessage);
      }
    } on ConflictException catch (e) {
      throw ConflictException(e.message);
    }
  }

  //=-=-=-=-= Registration Detail =-=-=-=-=
  Future<RegistrationDetailsResponse> loadRegistrationDetail(int id) async {
    Response response = await get("${EndPoints.registration}/$id");
    switch (response.statusCode) {
      case 200:
        return RegistrationDetailsResponse.fromJson(response.data);
      default:
        return throw Exception('Error');
    }
  }

  //=-=-=-=-= Registration Delete =-=-=-=-=
  Future<String> loadRegistrationDelete(
      {int? id, int? subjectId, int? studentId}) async {
    Response response = await delete("${EndPoints.registration}/$id", data: {
      "student": studentId,
      "subject": subjectId,
    });
    switch (response.statusCode) {
      case 200:
        return response.data['message'];
      default:
        throw Exception('Error');
    }
  }
}

class ConflictException implements Exception {
  final String message;

  ConflictException(this.message);
}
