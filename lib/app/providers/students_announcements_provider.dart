import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/student_announcements_model.dart';

class StudentAnnouncementsProvider {
  static Future<Either<List<StudentAnnouncements>?, String>>
      getStudentAnnouncements(int student_id) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/StudentAnnouncements',
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
        List<StudentAnnouncements> studentAnnouncements =
            (result['result'] as List)
                .map((e) => StudentAnnouncements.fromJson(e))
                .toList();
        return left(studentAnnouncements);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
