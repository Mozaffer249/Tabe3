class AttendanceReport {
  AttendanceReport({
    this.classname,
    this.date,
    this.id,
    this.totalStudent,
    this.totalPresences,
    this.totalAbsent,
    this.state = '',
  });

  final String? classname;
  final DateTime? date;
  final int? id;
  final int? totalStudent;
  final int? totalPresences;
  final int? totalAbsent;
  final String? state;

  AttendanceReport copyWith({
    String? classname,
    DateTime? date,
    int? id,
    int? totalStudent,
    int? totalPresences,
    int? totalAbsent,
    String? state,
  }) =>
      AttendanceReport(
        classname: classname ?? this.classname,
        date: date ?? this.date,
        id: id ?? this.id,
        totalStudent: totalStudent ?? this.totalStudent,
        totalPresences: totalPresences ?? this.totalPresences,
        totalAbsent: totalAbsent ?? this.totalAbsent,
        state: state ?? this.state,
      );

  factory AttendanceReport.fromMap(Map<String, dynamic> json) =>
      AttendanceReport(
        classname: json["classname"] == null ? null : json["classname"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        id: json["id"] == null ? null : json["id"],
        totalStudent:
            json["total_student"] == null ? null : json["total_student"],
        totalPresences:
            json["total_presences"] == null ? null : json["total_presences"],
        totalAbsent: json["total_absent"] == null ? null : json["total_absent"],
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toMap() => {
        "classname": classname == null ? null : classname,
        "date": date == null ? null : date!.toIso8601String(),
        "id": id == null ? null : id,
        "total_student": totalStudent == null ? null : totalStudent,
        "total_presences": totalPresences == null ? null : totalPresences,
        "total_absent": totalAbsent == null ? null : totalAbsent,
        "state": state == null ? null : state,
      };
}
