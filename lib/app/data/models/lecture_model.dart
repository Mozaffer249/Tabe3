// To parse this JSON data, do
//
//     final lectureModel = lectureModelFromJson(jsonString);

import 'dart:convert';

LectureModel lectureModelFromJson(String str) =>
    LectureModel.fromJson(json.decode(str));

String lectureModelToJson(LectureModel data) => json.encode(data.toJson());

class LectureModel {
  LectureModel({
    this.index,
    this.subjectId,
    this.subjectName,
    this.image,
    this.teacher,
    this.teacherId,
    this.startTime,
    this.endTime,
  });

  final int? index;
  final int? subjectId;
  final String? subjectName;
  final String? image;
  final String? teacher;
  final String? startTime;
  final String? endTime;
  final int? teacherId;

  factory LectureModel.fromJson(Map<String, dynamic> json) => LectureModel(
        index: json["index"] == null ? null : json["index"],
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        subjectName: json["subject_name"] == null ? null : json["subject_name"],
        image: json["image"] == null ? null : json["image"],
        teacher: json["teacher"] == null ? null : json["teacher"],
        teacherId: json["teacher_id"] == null ? null : json["teacher_id"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "index": index == null ? null : index,
        "subject_id": subjectId == null ? null : subjectId,
        "subject_name": subjectName == null ? null : subjectName,
        "image": image == null ? null : image,
        "teacher": teacher == null ? null : teacher,
        "teacher_id": teacherId == null ? null : teacherId,
      };
}
