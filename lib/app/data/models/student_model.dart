// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    this.studentId,
    this.studentName,
    this.studentClass,
    this.studentCode,
    this.isAbsent = false,
    this.classId ,
    this.absentReason,
    this.parentPhone,
    this.parentMobile,
  });

  int? studentId;
  String? studentName;
  String? studentClass;
  String? studentCode;
  String? absentReason;
  String? parentPhone;
  String? parentMobile;
  int? classId;
  bool isAbsent;


  factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentId: json["student_id"] == null
            ? json['id'] == null
                ? null
                : json['id']
            : json["student_id"],

        classId: json["class_id"] == null
            ? json['class_id'] == null
                ? null
                : json['class_id']
            : json["class_id"],

        studentName: json["student_name"] == null
            ? json['name'] == null
                ? null
                : json['name']
            : json["student_name"],
        studentClass:
            json["student_class"] == null || json["student_class"] is bool
                ? null
                : json["student_class"],
        studentCode:
            json["student_code"] == null || json["student_code"] is bool
                ? null
                : json["student_code"],
        isAbsent: json["is_absent"] == null ? false : json["is_absent"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId == null ? null : studentId,
        "student_name": studentName == null ? null : studentName,
        "student_class": studentClass == null ? null : studentClass,
        "student_code": studentCode == null ? null : studentCode,
        "is_absent": isAbsent,
      };
}
