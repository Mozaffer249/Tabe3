// To parse this JSON data, do
//
//     final teacherSubject = teacherSubjectFromMap(jsonString);

import 'dart:convert';

TeacherSubject teacherSubjectFromMap(String str) =>
    TeacherSubject.fromMap(json.decode(str));

String teacherSubjectToMap(TeacherSubject data) => json.encode(data.toMap());

class TeacherSubject {
  TeacherSubject({
    this.subjectId,
    this.endTime,
    this.standard,
    this.subjectIcon,
    this.index,
    this.supervisior,
    this.startTime,
    this.dayOfWeek,
  });

  final String? subjectId;
  final String? endTime;
  final String? standard;
  final String? subjectIcon;
  final int? index;
  final String? supervisior;
  final String? startTime;
  final String? dayOfWeek;

  factory TeacherSubject.fromMap(Map<String, dynamic> json) => TeacherSubject(
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        standard: json["standard"] == null ? null : json["standard"],
        subjectIcon: json["subject_icon"] == null ? null : json["subject_icon"],
        index: json["index"] == null ? null : json["index"],
        supervisior: json["supervisior"] == null ? null : json["supervisior"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        dayOfWeek: json["day_of_week"] == null ? null : json["day_of_week"],
      );

  Map<String, dynamic> toMap() => {
        "subject_id": subjectId == null ? null : subjectId,
        "end_time": endTime == null ? null : endTime,
        "standard": standard == null ? null : standard,
        "subject_icon": subjectIcon == null ? null : subjectIcon,
        "index": index == null ? null : index,
        "supervisior": supervisior == null ? null : supervisior,
        "start_time": startTime == null ? null : startTime,
        "day_of_week": dayOfWeek == null ? null : dayOfWeek,
      };
}
