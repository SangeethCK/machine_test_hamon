import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/end_points.dart';
import 'package:machine_test/domain/core/api/network/base_api.dart';
import 'package:machine_test/domain/models/student/student_details.dart';
import 'package:machine_test/domain/models/student/student_response.dart';

class StudentsRepository extends BaseApi {
  //=-=-=-=-= Student -=-=-=

  Future<Either<String, List<StudentList>>> loadStudent() async {
    try {
      Response response = await get(EndPoints.students);

      switch (response.statusCode) {
        case 200:
          return Right((response.data['students'] as List)
              .map((e) => StudentList.fromJson(e))
              .toList());
        default:
          return const Left('Error');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  //=-=-=-== Student Details =-=-=-=-=
  Future<Either<String, StudentDetailResponse>> loadStudentDetail(
      int id) async {
    try {
      Response response = await 
          get('${EndPoints.studentDetails}/$id');
      switch (response.statusCode) {
        case 200:
          return Right(StudentDetailResponse.fromJson(response.data));
        default:
          return const Left('Error');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
