import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/end_points.dart';
import 'package:machine_test/domain/core/api/network/base_api.dart';
import 'package:machine_test/domain/models/subject/subject_detail_response.dart';
import 'package:machine_test/domain/models/subject/subject_response.dart';

class SubjectRepository extends BaseApi {
  //=-=-=-= Subject List =-=-=-=

  Future<List<SubjectList>> loadSubjectList() async {
    Response response = await get(EndPoints.subjects);
    switch (response.statusCode) {
      case 200:
        return (response.data['subjects'] as List)
            .map((e) => SubjectList.fromJson(e))
            .toList();

      default:
        throw Exception('Error');
    }
  }
  //=-=-=-= Subject Detail =-=-=-=

  Future<SubjectDetailResponse> loadSubjectDetails(int id) async {
    Response response = await get('${EndPoints.subjectDetail}$id');
    switch (response.statusCode) {
      case 200:
        return SubjectDetailResponse.fromJson(response.data);

      default:
        throw Exception('Error');
    }
  }
}
