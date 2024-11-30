class StudentAttendance {
  StudentAttendance({
    this.studentId,
    this.name,
    this.present,
    this.absentReason,
    this.date,
  });

    int? studentId;
    final String? name;
    bool? present;
    var absentReason;
    final String? date;


  StudentAttendance copyWith({
    String? name,
    bool? present,
  }) =>
      StudentAttendance(
        name: name ?? this.name,
        present: present ?? this.present,
      );

  factory StudentAttendance.fromMap(Map<String, dynamic> json) =>
      StudentAttendance(
        studentId: json["student_id"] == null ? null : json["student_id"],
        name: json["name"] == null ? null : json["name"],
        present: json["present"] == null ? null : json["present"],
        absentReason: json["absent_reason"] == null ? null : json["absent_reason"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "present": present == null ? null : present,
      };
}
