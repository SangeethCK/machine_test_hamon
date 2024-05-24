import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/end_points.dart';
import 'package:machine_test/domain/core/api/network/base_api.dart';
import 'package:machine_test/domain/models/registration/registration_detail_response.dart';
import 'package:machine_test/domain/models/registration/registration_response.dart';

class RegistrationRepository extends BaseApi {
  // Load Registration List
  Future<Either<Exception, List<Registration>>> loadRegistration() async {
    try {
      Response response = await get(EndPoints.registration);
      if (response.statusCode == 200) {
        List<Registration> registrations =
            (response.data['registrations'] as List)
                .map((e) => Registration.fromJson(e))
                .toList();
        return Right(registrations);
      } else {
        return Left(Exception('Error'));
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }

  // Create Registration
  Future<Either<Exception, RegistrationResponse>> createRegistration(
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
        RegistrationResponse registrationResponse =
            RegistrationResponse.fromJson(response.data);
        return Right(registrationResponse);
      } else {
        final errorMessage = response.data['error'];
        return Left(Exception(errorMessage));
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }

  // Load Registration Detail
  Future<Either<Exception, RegistrationDetailsResponse>> loadRegistrationDetail(
      int id) async {
    try {
      Response response = await get("${EndPoints.registration}/$id");
      if (response.statusCode == 200) {
        RegistrationDetailsResponse registrationDetailsResponse =
            RegistrationDetailsResponse.fromJson(response.data);
        return Right(registrationDetailsResponse);
      } else {
        return Left(Exception('Error'));
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }

  // Delete Registration
  Future<Either<Exception, String>> loadRegistrationDelete(
      {int? id, int? subjectId, int? studentId}) async {
    try {
      Response response = await delete("${EndPoints.registration}/$id", data: {
        "student": studentId,
        "subject": subjectId,
      });
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else {
        return Left(Exception('Error'));
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }
}
