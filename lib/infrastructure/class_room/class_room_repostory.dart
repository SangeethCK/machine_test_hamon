import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:machine_test/domain/core/api/end_point/end_points.dart';
import 'package:machine_test/domain/core/api/network/base_api.dart';
import 'package:machine_test/domain/models/class_room/class_room_details.dart';
import 'package:machine_test/domain/models/class_room/class_room_response.dart';
import 'package:machine_test/domain/models/class_room/update_classroom_subject_request.dart';

class ClassRoomRepostory extends BaseApi {
  //=-=-=-=-= Class Room -=-=-=
  Future<Either<Exception, List<Classroom>>> loadClassRoom() async {
    try {
      Response response = await get(EndPoints.classRommApi);
      if (response.statusCode == 200) {
        List<Classroom> classrooms = (response.data['classrooms'] as List)
            .map((e) => Classroom.fromJson(e))
            .toList();
        return Right(classrooms);
      } else {
        return Left(Exception('Error'));
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }

  //=-=-=--=-= Class Room Detail =-=-=-=-=-=
  Future<Either<Exception, ClassRoomDetailResponse>> loadClassRoomDetail(
      int id) async {
    try {
      Response response = await get('${EndPoints.classRommDetailApi}$id');
      if (response.statusCode == 200) {
        ClassRoomDetailResponse classRoomDetailResponse =
            ClassRoomDetailResponse.fromJson(response.data);
        return Right(classRoomDetailResponse);
      } else {
        return Left(Exception('Error'));
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }

  //=-=-=--=-= Class Room Updates =-=-=-=-=-=
  Future<Either<Exception, UpdateSubjectRequest>> updateClassRoomSubject(
      int id, UpdateSubjectRequest updateData) async {
    try {
      Response response = await patch('${EndPoints.classRommApi}$id',
          data: updateData.toJson());
      if (response.statusCode == 200) {
        UpdateSubjectRequest updatedData =
            UpdateSubjectRequest.fromJson(response.data);
        return Right(updatedData);
      } else {
        return Left(Exception('Error'));
      }
    } catch (e) {
      return Left(Exception('Error'));
    }
  }
}
