import 'package:dio/dio.dart';
import 'package:machine_test/domain/models/subject/subject_response.dart';

class SubjectRepository {
  final dio = Dio();

  Future<List<SubjectList>> loadSubjectList() async {
    Response response = await dio
        .get('https://nibrahim.pythonanywhere.com/subjects/?api_key=AB0Bf');
    switch (response.statusCode) {
      case 200:
        return (response.data['subjects'] as List)
            .map((e) => SubjectList.fromJson(e))
            .toList();

      default:
        throw Exception('Error');
    }
  }
}
