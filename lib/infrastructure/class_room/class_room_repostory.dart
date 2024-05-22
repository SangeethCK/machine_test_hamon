import 'package:dio/dio.dart';
import 'package:machine_test/domain/models/class_room/class_room_details.dart';
import 'package:machine_test/domain/models/class_room/class_room_response.dart';

class ClassRoomRepostory {
  final dio = Dio();
  //=-=-=-=-= Class Room -=-=-=
  Future<List<Classroom>> loadClassRoom() async {
    Response response = await dio
        .get('https://nibrahim.pythonanywhere.com/classrooms/?api_key=AB0Bf');
    switch (response.statusCode) {
      case 200:
        return (response.data['classrooms'] as List)
            .map((e) => Classroom.fromJson(e))
            .toList();
      default:
        return throw Exception('Error');
    }
  }

  Future<ClassRoomDetailResponse> loadClassRoomDetail(int id) async {
    Response response = await dio.get(
        'https://nibrahim.pythonanywhere.com/classrooms/$id?api_key=AB0Bf');
    switch (response.statusCode) {
      case 200:
        return ClassRoomDetailResponse.fromJson(response.data);
      default:
        return throw Exception('Error');
    }
  }
}
