// To parse this JSON data, do
//
//     final studentResult = studentResultFromMap(jsonString);

import 'dart:convert';

StudentResult studentResultFromMap(String str) =>
    StudentResult.fromMap(json.decode(str));

String studentResultToMap(StudentResult data) => json.encode(data.toMap());

class StudentResult {
  StudentResult({
    this.marksReeval,
    this.subject,
    this.exam,
    this.allowEdit,
    this.studentInfo,
    this.grade,
    this.rank,
    this.obtainMarks,
    this.maximumMarks,
  });

  final String? marksReeval;
  final KeyValueModel? subject;
  final KeyValueModel? exam;
  final int? allowEdit;
  final KeyValueModel? studentInfo;
  final String? grade;
  final String? rank;
  final double? obtainMarks;
  final double? maximumMarks;

  factory StudentResult.fromMap(Map<String, dynamic> json) => StudentResult(
        marksReeval: json["marks_reeval"] == null ? null : json["marks_reeval"],
        subject: json["subject"] == null
            ? null
            : KeyValueModel.fromMap(json["subject"]),
        exam: json["exam"] == null ? null : KeyValueModel.fromMap(json["exam"]),
        allowEdit: json["allow_edit"] == null ? null : json["allow_edit"],
        studentInfo: json["student_info"] == null
            ? null
            : KeyValueModel.fromMap(json["student_info"]),
        grade: json["grade"] == null ? null : json["grade"],
        rank: json["rank"] == null ? null : json["rank"],
        obtainMarks: json["obtain_marks"] == null ? null : json["obtain_marks"],
        maximumMarks: json["maximum_marks"] == null ? null : json["maximum_marks"],
      );

  Map<String, dynamic> toMap() => {
        "marks_reeval": marksReeval == null ? null : marksReeval,
        "subject": subject == null ? null : subject!.toMap(),
        "exam": exam == null ? null : exam!.toMap(),
        "allow_edit": allowEdit == null ? null : allowEdit,
        "student_info": studentInfo == null ? null : studentInfo!.toMap(),
        "grade": grade == null ? null : grade,
        "rank": rank == null ? null : rank,
        "obtain_marks": obtainMarks == null ? null : obtainMarks,
        "maximum_marks": maximumMarks == null ? null : maximumMarks,
      };
}

class KeyValueModel {
  KeyValueModel({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory KeyValueModel.fromMap(Map<String, dynamic> json) => KeyValueModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
