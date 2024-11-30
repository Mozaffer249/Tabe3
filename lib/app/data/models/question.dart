
import 'package:tabee3_flutter/app/data/models/Tests.dart';
import 'package:tabee3_flutter/app/data/models/choice.dart';

class Question {
  int? id;
  String? text;
  String? type;
  int? testId;
  Tests? test;
  List<Choice>? choices;

  Question({this.id, this.text, this.type, this.testId, this.test, this.choices});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    text = json['Text'];
    type = json['Type'];
    testId = json['TestId'];
    test = json['Test'] != null ? new Tests.fromJson(json['Test']) : null;
    if (json['Choices'] != null) {
      choices = <Choice>[];
      json['Choices'].forEach((v) { choices!.add(new Choice.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Text'] = this.text;
    data['Type'] = this.type;
    data['TestId'] = this.testId;
    if (this.test != null) {
      data['Test'] = this.test!.toJson();
    }
    if (this.choices != null) {
      data['Choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


