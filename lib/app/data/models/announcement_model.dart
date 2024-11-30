// To parse this JSON data, do
//
//     final announcement = announcementFromMap(jsonString);

import 'dart:convert';

Announcement announcementFromMap(String str) =>
    Announcement.fromJson(json.decode(str));

String announcementToMap(Announcement data) => json.encode(data.toMap());

class Announcement {
  Announcement({
    this.date,
    this.createUid,
    this.companyId,
    this.classId,
    this.writeDate,
    this.writeUid,
    this.lastUpdate,
    this.name,
    this.yearId,
    this.schoolId,
    this.displayName,
    this.createDate,
    this.id,
    this.body,
  });

  final DateTime? date;
  final List<dynamic>? companyId;
  final DateTime? writeDate;
  final DateTime? lastUpdate;
  final String? name;
  final String? displayName;
  final DateTime? createDate;
  final int? id;
  final String? body;
  final List<dynamic>? createUid;
  final List<dynamic>? classId;
  final List<dynamic>? writeUid;
  final List<dynamic>? yearId;
  final List<dynamic>? schoolId;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createUid: json["create_uid"] == null
            ? null
            : List<dynamic>.from(json["create_uid"]!.map((x) => x)),
        companyId: json["company_id"] == null || json["company_id"] is bool
            ? null
            : json["company_id"],
        classId: json["class_id"] == null
            ? null
            : List<dynamic>.from(json["class_id"]!.map((x) => x)),
        writeDate: json["write_date"] == null
            ? null
            : DateTime.parse(json["write_date"]),
        writeUid: json["write_uid"] == null
            ? null
            : List<dynamic>.from(json["write_uid"]!.map((x) => x)),
        lastUpdate: json["__last_update"] == null
            ? null
            : DateTime.parse(json["__last_update"]),
        name: json["name"] == null ? null : json["name"],
        yearId: json["year_id"] == null || json["year_id"] is bool
            ? null
            : List<dynamic>.from(json["year_id"]!.map((x) => x)),
        schoolId: json["school_id"] == null || json["school_id"] is bool
            ? null
            : List<dynamic>.from(json["school_id"]!.map((x) => x)),
        displayName: json["display_name"] == null ? null : json["display_name"],
        createDate: json["create_date"] == null
            ? null
            : DateTime.parse(json["create_date"]),
        id: json["id"] == null ? null : json["id"],
        body: json["body"] == null ? null : json["body"],
      );

  Map<String, dynamic> toMap() => {
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "create_uid": createUid == null
            ? null
            : List<dynamic>.from(createUid!.map((x) => x)),
        "company_id": companyId == null ? null : companyId,
        "class_id":
            classId == null ? null : List<dynamic>.from(classId!.map((x) => x)),
        "write_date": writeDate == null ? null : writeDate!.toIso8601String(),
        "write_uid": writeUid == null
            ? null
            : List<dynamic>.from(writeUid!.map((x) => x)),
        "__last_update":
            lastUpdate == null ? null : lastUpdate!.toIso8601String(),
        "name": name == null ? null : name,
        "year_id":
            yearId == null ? null : List<dynamic>.from(yearId!.map((x) => x)),
        "school_id": schoolId == null
            ? null
            : List<dynamic>.from(schoolId!.map((x) => x)),
        "display_name": displayName == null ? null : displayName,
        "create_date":
            createDate == null ? null : createDate!.toIso8601String(),
        "id": id == null ? null : id,
        "body": body == null ? null : body,
      };
}
