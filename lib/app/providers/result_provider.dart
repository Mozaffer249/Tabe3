import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/result_model.dart';
import 'package:tabee3_flutter/app/data/models/student_result.dart';

class ResultProvider {
  static Future<Either<Map<String, dynamic>, String>> getResult(
    int student_id,
    int exam_id,
  ) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/GetResult',
        data: {
          "params": {
            "student_id": student_id,
            "exam_id": exam_id,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];

      if (result.containsKey('status') && result['status'] == 1) {
        List<Result> resultList = (result['exam_ids'] as List)
            .map((e) => Result.fromJson(e))
            .toList();
        final res = {
          'data': resultList,
          'result': ResultSummary.fromMap(result['summary']),
        };
        return left(res);
      } else {
        return right(result['message']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<StudentResult>?, String>> getStudentResult(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getresult',
        data: {"params": request},
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];

      if (result.containsKey('status') && result['status']) {
        List<StudentResult> resultList = (result['student_result'] as List)
            .map((e) => StudentResult.fromMap(e))
            .toList();
        return left(resultList);
      } else {
        return right(result['msg'] ?? '');
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<StudentResult>, String>> getResultForSubject(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getresult',
        data: {"params": request},
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];

      if (result.containsKey('status') && result['status']) {
        List<StudentResult> resultList = (result['student_result'] as List)
            .map((e) => StudentResult.fromMap(e))
            .toList();
        return left(resultList);
      } else {
        return right(result['msg'] ?? '');
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
