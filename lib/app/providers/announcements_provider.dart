import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/announcement_model.dart';
import 'package:tabee3_flutter/app/data/models/student_announcements_model.dart';

class AnnouncementsProvider {
  static Future<Either<List<Announcement>?, String>> getAnnouncements(
      int teacherId, int classId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/ReadAnnounce',
        data: {
          "params": {
            "teacher_id": teacherId,
            "class_id": classId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<Announcement> announcements = (result['data'] as List)
            .map((e) => Announcement.fromJson(e))
            .toList();
        return left(announcements);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<StudentAnnouncements>?, String>>
      getGeneralAnnouncements(int? customerId, int? studentId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/generalAnnouncements',
        data: {
          "params": {
            "customer_id": customerId,
            "student_id": studentId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<StudentAnnouncements> announcements = (result['result'] as List)
            .map((e) => StudentAnnouncements.fromJson(e))
            .toList();
        return left(announcements);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>> addAnnouncement(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/addAnnounce',
        data: {"params": request},
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

  static Future<Either<bool, String>> deleteAnnouncement(int id) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/deleteAnnounce',
        data: {
          "params": {"id": id}
        },
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
