import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/attendance_model.dart';
import 'package:tabee3_flutter/app/data/models/attendance_report_model.dart';
import 'package:tabee3_flutter/app/data/models/studnet_attendance_model.dart';

class AttendanceProivder {
  static Future<Either<bool, String>> submitAttendance(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/submitAttendance',
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

  static Future<Either<Attendance, String>> getAttendnaceForSubject(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getAttendance',
        data: {"params": request},
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        final attendance = Attendance.fromMap(result);
        return left(attendance);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<AttendanceReport>, String>> getAttendanceReport(
      int attendanceId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/viewAttendance',
        data: {
          "params": {
            "customer_id": attendanceId,
          }
        },
      );
      if (response.data['result'].containsKey("error")) {
        return right(response.data['result']['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        final attendance = (result['result'] as List)
            .map((e) => AttendanceReport.fromMap(e))
            .toList();
        return left(attendance);
      } else {
        return right(result['message']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<Map<String, dynamic>, String>> getStudentAttendance(
      int attendanceId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/viewStudentAttendance',
        data: {
          "params": {
            "attendance_id": attendanceId,
          }
        },
      );
      if (response.data['result'].containsKey("error")) {
        return right(response.data['result']['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        final res = <String, dynamic>{};
        final attendance = (result['students'] as List)
            .map((e) => StudentAttendance.fromMap(e))
            .toList();
        res['attendance'] = attendance;
        res['aprroved'] = response.data['result']['result'][0]['approved'];
        res['report'] = AttendanceReport.fromMap(result['result'][0]);
        return left(res);
      } else {
        return right(result['message']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<Map<String, dynamic>, String>> getStudentAttendanceRecord( Map<String, dynamic> request ) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/StudentAttendanceRecord',
        data: {
          "params":request
        },
      );
      if (response.data['result'].containsKey("error")) {
        return right(response.data['result']['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        final res = <String, dynamic>{};
        final attendance = (result['students'] as List).map((e) => StudentAttendance.fromMap(e)).toList();
        res['students'] = attendance;
        return left(res);
      } else {
        return right(result['message']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>>updateAttendence(
      Map<String, dynamic> request)async
  {

    try{
      var response=await DioClient.DIO_CLIENT.post(
          "/updateAttendance",
      data: {"params": request},
      );
      if (response.data.containsKey("error")) {
        return right(response.data['error']['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        return left(true);
      } else {
        return right(result['message']);
      }
    }
    catch(e){
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>> confirmStudentAttendance(
      int attendanceId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/coinfirmStudentAttendance',
        data: {
          "params": {
            "attendance_id": attendanceId,
          }
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['error']['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        return left(true);
      } else {
        return right(result['message']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
