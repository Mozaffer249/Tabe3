class Lesson {
  Lesson({
    this.createUid,
    this.type,
    this.teacherId,
    this.lesson,
    this.url,
    this.writeUid,
    this.lastUpdate,
    this.name,
    this.writeDate,
    this.displayName,
    this.createDate,
    this.id,
    this.subjectId,
  });

  final List<dynamic>? createUid;
   var type;
  final List<dynamic>? teacherId;
  final String? lesson;
  String? url;
  final List<dynamic>? writeUid;
  final DateTime? lastUpdate;
  final String? name;
  final DateTime? writeDate;
  final String? displayName;
  final DateTime? createDate;
  final int? id;
  final List<dynamic>? subjectId;

  factory Lesson.fromMap(Map<String, dynamic> json) => Lesson(
        createUid: json["create_uid"] == null
            ? null
            : List<dynamic>.from(json["create_uid"]!.map((x) => x)),
        type: json["type"] == null ? null : json["type"],
        teacherId: json["teacher_id"] == null || json["teacher_id"] is bool
            ? null
            : List<dynamic>.from(json["teacher_id"]!.map((x) => x)),
        lesson: json["lesson"] == null || json["lesson"] is bool
            ? null
            : json["lesson"],
        url: json["url"] == null || json["url"] is bool ? null : json["url"],
        writeUid: json["write_uid"] == null
            ? null
            : List<dynamic>.from(json["write_uid"]!.map((x) => x)),
        lastUpdate: json["__last_update"] == null
            ? null
            : DateTime.parse(json["__last_update"]),
        name: json["name"] == null ? null : json["name"],
        writeDate: json["write_date"] == null
            ? null
            : DateTime.parse(json["write_date"]),
        displayName: json["display_name"] == null ? null : json["display_name"],
        createDate: json["create_date"] == null
            ? null
            : DateTime.parse(json["create_date"]),
        id: json["id"] == null ? null : json["id"],
        subjectId: json["subject_id"] == null
            ? null
            : List<dynamic>.from(json["subject_id"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "create_uid": createUid == null
            ? null
            : List<dynamic>.from(createUid!.map((x) => x)),
        "type": type == null ? null : type,
        "teacher_id": teacherId == null
            ? null
            : List<dynamic>.from(teacherId!.map((x) => x)),
        "lesson": lesson == null ? null : lesson,
        "url": url == null ? null : url,
        "write_uid": writeUid == null
            ? null
            : List<dynamic>.from(writeUid!.map((x) => x)),
        "__last_update":
            lastUpdate == null ? null : lastUpdate!.toIso8601String(),
        "name": name == null ? null : name,
        "write_date": writeDate == null ? null : writeDate!.toIso8601String(),
        "display_name": displayName == null ? null : displayName,
        "create_date":
            createDate == null ? null : createDate!.toIso8601String(),
        "id": id == null ? null : id,
        "subject_id": subjectId == null
            ? null
            : List<dynamic>.from(subjectId!.map((x) => x)),
      };
}
