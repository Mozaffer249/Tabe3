import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/teacher_subject.dart';

class LectureProvider {
  static Future<Either<Map<String, dynamic>?, String>> getLectures(
      int student_id) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getStudentTimetable',
        data: json.encode({
          "params": {
            "student_id": student_id,
          }
        }),
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        final data = result['timetable'];
        return left(data);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<TeacherSubject>, String>> getTimeTableTeahcer(
      int teahcerId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getTimeTableTeacher',
        data: json.encode({
          "params": {
            "teacher_id": teahcerId,
          }
        }),
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        final data = (result['time_table'] as List)
            .map((e) => TeacherSubject.fromMap(e))
            .toList();
        return left(data);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
