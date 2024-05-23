import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/end_points.dart';
import 'package:machine_test/domain/core/api/interceptor/interceptor.dart';
import 'package:machine_test/domain/models/class_room/class_room_details.dart';
import 'package:machine_test/domain/models/class_room/class_room_response.dart';
import 'package:machine_test/domain/models/class_room/update_classroom_subject_request.dart';

class ClassRoomRepostory {
  //=-=-=-=-= Class Room -=-=-=
  Future<List<Classroom>> loadClassRoom() async {
    Response response = await NetworkProvider().get(EndPoints.classRommApi);
    switch (response.statusCode) {
      case 200:
        return (response.data['classrooms'] as List)
            .map((e) => Classroom.fromJson(e))
            .toList();
      default:
        return throw Exception('Error');
    }
  }
//=-=-=--=-= Class Room Detail =-=-=-=-=-=

  Future<ClassRoomDetailResponse> loadClassRoomDetail(int id) async {
    Response response = await NetworkProvider()
        .get('${EndPoints.classRommDetailApi}$id?api_key=AB0Bf');
    switch (response.statusCode) {
      case 200:
        return ClassRoomDetailResponse.fromJson(response.data);
      default:
        return throw Exception('Error');
    }
  }

//=-=-=--=-= Class Room Updates =-=-=-=-=-=
  Future<UpdateSubjectRequest> updateClassRoomSubject(
      int id, UpdateSubjectRequest updateData) async {
    Response response = await NetworkProvider().patch(
        'https://nibrahim.pythonanywhere.com/classrooms/$id?api_key=AB0Bf',
        data: updateData.toJson());
    switch (response.statusCode) {
      case 200:
        return response.data;
      default:
        return throw Exception('Error');
    }
  }
}
