import 'package:tabee3_flutter/app/data/models/question.dart';

class Tests {
  int? id;
  String? name;
  List<String>? classessNames;
  String? date;
  List<Question>? questions;


  Tests({this.id, this.name,this.classessNames, this.date, this.questions});

  Tests.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    date = json['DateCreated'];
    if (json['Questions'] != null) {
      questions = <Question>[];
      json['Questions'].forEach((v) {
        questions!.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['DateCreated'] = this.date;
    if (this.questions != null) {
      data['Questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
