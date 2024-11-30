import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/lesson_model.dart';

class LessonProvider {
  static Future<Either<List<Lesson>?, String>> getLessons(int subjectId,int classId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/ReadLesson',
        data: json.encode({
          "params": {
            "subject_id": subjectId,
            "class_id": classId,
          }
        }),
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        final data =
            (result['data'] as List).map((e) => Lesson.fromMap(e)).toList();
        return left(data);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>> uploadLesson(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/UploadLesson',
        data: json.encode({"params": request}),
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        return left(true);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>> deleteLesson(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/DeleteLesson',
        data: json.encode({"params": request}),
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        return left(true);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
