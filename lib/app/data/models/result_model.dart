// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  Result({
    this.subject,
    this.grade,
    this.obtainedMarks,
    this.minimumMarks,
    this.maximumMarks,
  });

  String? subject;
  String? grade;
  double? obtainedMarks;
  double? minimumMarks;
  double? maximumMarks;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        subject: json["subject"] == null ? null : json["subject"],
        grade: json["grade"] == null || json["grade"] is bool
            ? null
            : json["grade"],
        obtainedMarks:
            json["obtained_marks"] == null ? null : json["obtained_marks"],
        minimumMarks:
            json["minimum_marks"] == null ? null : json["minimum_marks"],
        maximumMarks:
            json["maximum_marks"] == null ? null : json["maximum_marks"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject == null ? null : subject,
        "grade": grade == null ? null : grade,
        "obtained_marks": obtainedMarks == null ? null : obtainedMarks,
        "minimum_marks": minimumMarks == null ? null : minimumMarks,
        "maximum_marks": maximumMarks == null ? null : maximumMarks,
      };
}

class ResultSummary {
  ResultSummary( {
    this.average,
    this.total,
    this.grade,
    this.percentage,
    this.result,
    this.image,
  });

  final double? average;
  final double? total;
  final String? grade;
  final double? percentage;
  final String? result;
   var image ;
  factory ResultSummary.fromMap(Map<String, dynamic> json) => ResultSummary(
        average: json["average"] == null ? null : json["average"].toDouble(),
        total: json["total"] == null ? null : json["total"] * 1.0,
        grade: json["grade"] == null ? null : json["grade"],
        percentage: json["percentage"] == null ? null : json["percentage"] * 1.0,
        result: json["result"] == null ? null : json["result"],
        image: json["image"] == null ? null : json["image"],

      );

  Map<String, dynamic> toMap() => {
        "average": average == null ? null : average,
        "total": total == null ? null : total,
        "grade": grade == null ? null : grade,
        "percentage": percentage == null ? null : percentage,
        "result": result == null ? null : result,
        "image": image == null ? null : image,
      };
}
