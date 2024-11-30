// To parse this JSON data, do
//
//     final parent = parentFromMap(jsonString);

import 'dart:convert';

Parent parentFromMap(String str) => Parent.fromJson(json.decode(str));

String parentToMap(Parent data) => json.encode(data.toMap());

class Parent {
  Parent({
    this.name,
    this.id,
    this.parentName,
    this.parentId,
    this.mobile,
  });

  final String? name;
  final int? id;
  final String? parentName;
  final String? mobile;
  final int? parentId;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        parentName: json["parent_name"] == null || json["parent_name"] is bool
            ? null
            : json["parent_name"],
        parentId: json["parent_id"] == null || json["parent_id"] is bool
            ? null
            : json["parent_id"],
        mobile: json["mobile"] == null || json["mobile"] is bool
            ? null
            : json["mobile"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "parent_name": parentName == null ? null : parentName,
        "parent_id": parentId == null ? null : parentId,
        "mobile": mobile == null ? null : mobile,
      };
}
