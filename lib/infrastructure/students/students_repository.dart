import 'package:dio/dio.dart';
import 'package:machine_test/domain/models/student/student_details.dart';
import 'package:machine_test/domain/models/student/student_response.dart';

class StudentsRepository {
  //=-=-=-=-= Student -=-=-=
  final dio = Dio();
  Future<List<StudentList>> loadStudent() async {
    Response response = await dio
        .get('https://nibrahim.pythonanywhere.com/students/?api_key=AB0Bf');
    switch (response.statusCode) {
      case 200:
        return (response.data['students'] as List)
            .map((e) => StudentList.fromJson(e))
            .toList();
      default:
        return throw Exception('Error');
    }
  }

//=-=-=-== Student Details =-=-=-=-=
  Future<StudentDetailResponse> loadStudentDetil(int id) async {
    Response response = await dio
        .get('https://nibrahim.pythonanywhere.com//students/$id?api_key=AB0Bf');
    switch (response.statusCode) {
      case 200:
        return StudentDetailResponse.fromJson(response.data);

      default:
        return throw Exception('Error');
    }
  }
}
