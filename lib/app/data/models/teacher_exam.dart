// To parse this JSON data, do
//
//     final teacherExam = teacherExamFromMap(jsonString);

import 'dart:convert';

GeneralExam teacherExamFromMap(String str) =>
    GeneralExam.fromMap(json.decode(str));

String teacherExamToMap(GeneralExam data) => json.encode(data.toMap());

class GeneralExam {
  GeneralExam({
    this.supervisior,
    this.startTime,
    this.subjectId,
    this.date,
    this.endTime,
  });

  final String? supervisior;
  final String? startTime;
  final String? subjectId;
  final DateTime? date;
  final String? endTime;

  factory GeneralExam.fromMap(Map<String, dynamic> json) => GeneralExam(
        supervisior: json["supervisior"] == null ? null : json["supervisior"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        endTime: json["end_time"] == null ? null : json["end_time"],
      );

  Map<String, dynamic> toMap() => {
        "supervisior": supervisior == null ? null : supervisior,
        "start_time": startTime == null ? null : startTime,
        "subject_id": subjectId == null ? null : subjectId,
        "date": date == null ? null : date!.toIso8601String(),
        "end_time": endTime == null ? null : endTime,
      };
}
