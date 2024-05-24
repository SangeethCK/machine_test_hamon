import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/interceptor/base_api.dart';
import 'package:machine_test/domain/models/registration/registration_detail_response.dart';
import 'package:machine_test/domain/models/registration/registration_response.dart';

class RegistrationRepository extends BaseApi {
  //=-=-=-=-= Registration List =-=-=-=-=
  Future<List<Registration>> loadRegistration() async {
    Response response =
        await get('http://nibrahim.pythonanywhere.com/registration/');

    switch (response.statusCode) {
      case 200:
        return (response.data['registrations'] as List)
            .map((e) => Registration.fromJson(e))
            .toList();
      default:
        return throw Exception('Error');
    }
  }

  //=-=-=-=-==-= New Registration =-=-=-=-=-==

  // Future<RegistrationResponse> createRegistration(
  //     int studentId, int subjectId) async {
  //   try {
  //     Response response = await NetworkProvider().post(
  //       'http://nibrahim.pythonanywhere.com/registration/',
  //       data: {
  //         "student": studentId,
  //         "subject": subjectId,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       return RegistrationResponse.fromJson(response.data);
  //     } else {
  //       log("what${response.data['error']}");
  //       // If the response status code is not 200, handle the error
  //       throw Exception(response.data['error'] ?? 'Unknown error');
  //     }
  //   } catch (e) {
  //     // Handle any exceptions that occur during the API call
  //     throw Exception('Error: $e');
  //   }
  // }

  Future<RegistrationResponse> createRegistration(
      int studentId, int subjectId) async {
    try {
      Response response = await post(
        'http://nibrahim.pythonanywhere.com/registration/',
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

  //=-=-=-=-= Registration List =-=-=-=-=
  Future<RegistrationDetailsResponse> loadRegistrationDetail(int id) async {
    Response response =
        await get("http://nibrahim.pythonanywhere.com/registration/$id");
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
    Response response = await delete(
        "http://nibrahim.pythonanywhere.com/registration/$id",
        data: {
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
