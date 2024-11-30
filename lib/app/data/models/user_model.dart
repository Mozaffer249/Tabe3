// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.companyId,
    this.name,
    this.verify,
    this.mobile,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName,
    this.userType,
    this.schoolName,
    this.image,
    this.attendanceAdmin = false,
  });

  int? id;
  int? companyId;
  String? name;
  String? verify;
  String? mobile;
  String? countryId;
  String? countryName;
  String? cityId;
  String? cityName;
  String? userType;
  String? schoolName;
  String? image;
  bool attendanceAdmin;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        name: json["name"] == null ? null : json["name"].toString(),
        verify: json["verify"] == null ? null : json["verify"].toString(),
        mobile: json["mobile"] == null ? null : json["mobile"].toString(),
        countryId: json["country_id"] == null || json["country_id"] is bool
            ? null
            : json["country_id"].toString(),
        countryName:
            json["country_name"] == null || json["country_name"] is bool
                ? null
                : json["country_name"].toString(),
        cityId: json["city_id"] == null || json["city_id"] is bool
            ? null
            : json["city_id"].toString(),
        cityName: json["city_name"] == null || json["city_name"] is bool
            ? null
            : json["city_name"].toString(),
        userType:
            json["user_type"] == null ? null : json["user_type"].toString(),
        schoolName:
            json["school_name"] == null ? null : json["school_name"].toString(),
        image: json["image"] == null ? null : json["image"].toString(),
        attendanceAdmin: json["attendance_admin"] == null ? false : json["attendance_admin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "company_id": companyId == null ? null : companyId,
        "name": name == null ? null : name,
        "verify": verify == null ? null : verify,
        "mobile": mobile == null ? null : mobile,
        "country_id": countryId == null ? null : countryId,
        "country_name": countryName == null ? null : countryName,
        "city_id": cityId == null ? null : cityId,
        "city_name": cityName == null ? null : cityName,
        "user_type": userType == null ? null : userType,
        "school_name": schoolName == null ? null : schoolName,
        "image": image == null ? null : image,
        "attendance_admin": attendanceAdmin == null ? false : attendanceAdmin,
      };
}
