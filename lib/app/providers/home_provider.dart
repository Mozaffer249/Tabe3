import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';

class HomeProvider {
  static Future<Either<List<Student>?, String>> getStudents(
      int customerId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getStudents',
        data: {
          "params": {
            "customer_id": customerId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        if (result['result'].containsKey('available_student')) {
          List<Student> students =
              (result['result']['available_student'] as List)
                  .map((e) => Student.fromJson(e))
                  .toList();
          return left(students);
        } else {
          return right(result['result']['message']);
        }
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
