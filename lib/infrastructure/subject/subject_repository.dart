import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/end_points.dart';
import 'package:machine_test/domain/core/api/interceptor/interceptor.dart';
import 'package:machine_test/domain/models/subject/subject_detail_response.dart';
import 'package:machine_test/domain/models/subject/subject_response.dart';

class SubjectRepository {
  Future<List<SubjectList>> loadSubjectList() async {
    Response response = await NetworkProvider().get(EndPoints.subjects);
    switch (response.statusCode) {
      case 200:
        return (response.data['subjects'] as List)
            .map((e) => SubjectList.fromJson(e))
            .toList();

      default:
        throw Exception('Error');
    }
  }

  Future<SubjectDetailResponse> loadSubjectDetails(int id) async {
    Response response = await NetworkProvider()
        .get('${EndPoints.subjectDetail}$id?api_key=AB0Bf');
    switch (response.statusCode) {
      case 200:
        return SubjectDetailResponse.fromJson(response.data);

      default:
        throw Exception('Error');
    }
  }
}
