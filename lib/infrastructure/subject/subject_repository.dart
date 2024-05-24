import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/end_points.dart';
import 'package:machine_test/domain/core/api/network/base_api.dart';
import 'package:machine_test/domain/models/subject/subject_detail_response.dart';
import 'package:machine_test/domain/models/subject/subject_response.dart';

class SubjectRepository extends BaseApi {
  //=-=-=-= Subject List =-=-=-=

  Future<Either<Exception, List<SubjectList>>> loadSubjectList() async {
    try {
      Response response = await get(EndPoints.subjects);
      if (response.statusCode == 200) {
        List<SubjectList> subjectList = (response.data['subjects'] as List)
            .map((e) => SubjectList.fromJson(e))
            .toList();
        return Right(subjectList);
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }
  //=-=-=-= Subject Detail =-=-=-=

  Future<Either<Exception, SubjectDetailResponse>> loadSubjectDetails(
      int id) async {
    try {
      Response response = await get('${EndPoints.subjectDetail}$id');
      if (response.statusCode == 200) {
        SubjectDetailResponse subjectDetailResponse =
            SubjectDetailResponse.fromJson(response.data);
        return Right(subjectDetailResponse);
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }
}
