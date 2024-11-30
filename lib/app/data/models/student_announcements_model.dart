// To parse this JSON data, do
//
//     final studentAnnouncements = studentAnnouncementsFromJson(jsonString);

import 'dart:convert';

StudentAnnouncements studentAnnouncementsFromJson(String str) =>
    StudentAnnouncements.fromJson(json.decode(str));

String studentAnnouncementsToJson(StudentAnnouncements data) =>
    json.encode(data.toJson());

class StudentAnnouncements {
  StudentAnnouncements({
    this.title,
    this.body,
    this.date,
  });

  String? title;
  String? body;
  DateTime? date;

  factory StudentAnnouncements.fromJson(Map<String, dynamic> json) =>
      StudentAnnouncements(
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "body": body == null ? null : body,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}
