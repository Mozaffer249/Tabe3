// To parse this JSON data, do
//
//     final exams = examsFromJson(jsonString);

import 'dart:convert';

ExamModel examsFromJson(String str) => ExamModel.fromJson(json.decode(str));

String examsToJson(ExamModel data) => json.encode(data.toJson());

class ExamModel {
  ExamModel({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.state,
  });

  int? id;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? state;

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "start_date": startDate == null
            ? null
            : "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": endDate == null
            ? null
            : "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "state": state == null ? null : state,
      };
}
