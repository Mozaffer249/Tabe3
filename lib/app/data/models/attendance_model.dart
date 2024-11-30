import 'dart:convert';

Attendance attendanceFromMap(String str) =>
    Attendance.fromMap(json.decode(str));

String attendanceToMap(Attendance data) => json.encode(data.toMap());

class Attendance {
  Attendance({
    this.holidays,
    this.attendance,
    this.range,
    this.status,
    this.officialHolidays,
  });

  final List<Holiday>? holidays;
  final List<String>? attendance;
  final Range? range;
  final int? status;
  final List<int>? officialHolidays;

  factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
        holidays: json["holidays"] == null
            ? null
            : List<Holiday>.from(
                json["holidays"].map((x) => Holiday.fromMap(x))),
        attendance: json["attendance"] == null
            ? null
            : List<String>.from(json["attendance"].map((x) => x.toString())),
        range: json["range"] == null ? null : Range.fromMap(json["range"]),
        status: json["status"] == null ? null : json["status"],
        officialHolidays: json["official_holidays"] == null
            ? null
            : List<int>.from(json["official_holidays"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "holidays": holidays == null
            ? null
            : List<dynamic>.from(holidays!.map((x) => x.toMap())),
        "attendance": attendance == null
            ? null
            : List<dynamic>.from(attendance!.map((x) => x)),
        "range": range == null ? null : range!.toMap(),
        "status": status == null ? null : status,
        "official_holidays": officialHolidays == null
            ? null
            : List<dynamic>.from(officialHolidays!.map((x) => x)),
      };
}

class Holiday {
  Holiday({
    this.name,
    this.date,
  });

  final String? name;
  final DateTime? date;

  factory Holiday.fromMap(Map<String, dynamic> json) => Holiday(
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "date": date == null ? null : date!.toIso8601String(),
      };
}

class Range {
  Range({
    this.from,
    this.to,
  });

  final DateTime? from;
  final DateTime? to;

  factory Range.fromMap(Map<String, dynamic> json) => Range(
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
      );

  Map<String, dynamic> toMap() => {
        "from": from == null ? null : from!.toIso8601String(),
        "to": to == null ? null : to!.toIso8601String(),
      };
}
