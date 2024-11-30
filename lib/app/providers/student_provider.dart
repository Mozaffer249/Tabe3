import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/ViewModel/student_parent_view_model.dart';
import 'package:tabee3_flutter/app/data/models/parent_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';

class StudentsProvider {
  static Future<Either<List<Student>?, String>> getStudentsInClass(
      int classId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getClassStudents',
        data: {
          "params": {
            "class_id": classId,
          }
        },
      );

      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        List<Student> students =
            (result['result'] as List).map((e) => Student.fromJson(e)).toList();
        return left(students);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<StudentParentModel>?, String>> getClassStudentWithParent(
      int classId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getClassStudentWithParent',
        data: {
          "params": {
            "class_id": classId,
          }
        },
      );

      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];

      if (result.containsKey('status') && result['status'] == 1) {
        List<StudentParentModel> student_parent = (result['students'] as List)
            .map((e) => StudentParentModel.fromJson(e))
            .toList();
        return left(student_parent);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<List<Subject>?, String>> getStudentSubject(
      int studentId) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/getsubject',
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
        List<Subject> parents = (result['student_subjects'] as List)
            .map((e) => Subject.fromMap(e))
            .toList();
        return left(parents);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }

  static Future<Either<bool, String>> addNewStudent(
      Map<String, dynamic> request) async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/registerStudent',
        data: {"params": request},
      );

      if (response.data.containsKey("error")) {
        return right(response.data['message']);
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

  static Future<Either<bool, String>> addBehavior( Map<String, dynamic> request )async
  {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/addbehavoir',
        data: {
          "params":request
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

  static Future<Either<Map<String, dynamic>, String>> getStudentBehavior( Map<String, dynamic> request )async
  {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/behavoir',
        data: {
          "params":request
        },
      );
      if (response.data.containsKey("error")) {
        return right(response.data['result']['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        return left(result);
      } else {
        return right(result['message']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
