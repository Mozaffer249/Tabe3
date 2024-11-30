import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/exams_model.dart';
import 'package:tabee3_flutter/app/data/models/teacher_exam.dart';

class ExamProvider {
  static Future<Either<List<ExamModel>?, String>> getExams(
      int student_id) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/GetExams',
        data: {
          "params": {
            "student_id": student_id,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<ExamModel> exams = (result['exams'] as List)
            .map((e) => ExamModel.fromJson(e))
            .toList();
        return left(exams);
      } else {
        return right(result['msg'] ?? result['message']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<GeneralExam>?, String>> getTeacherExams(
      int teacherId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getexamtable',
        data: {
          "params": {
            "teacher_id": teacherId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<GeneralExam> exams = (result['time_table'] as List)
            .map((e) => GeneralExam.fromMap(e))
            .toList();
        return left(exams);
      } else {
        return right(result['msg'] ?? "");
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<GeneralExam>?, String>> getStudentExams(
      int studentId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getexamtable',
        data: {
          "params": {
            "student_id": studentId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<GeneralExam> exams = (result['time_table'] as List)
            .map((e) => GeneralExam.fromMap(e))
            .toList();
        return left(exams);
      } else {
        return right(result['msg'] ?? "");
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
