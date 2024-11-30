import 'package:tabee3_flutter/app/data/models/question.dart';

class Choice {
  int? id;
  String? text;
  bool? isCorrect;
  String? questionId;
  Question? question;

  Choice({this.id, this.text, this.isCorrect, this.questionId, this.question});

  Choice.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    text = json['Text'];
    isCorrect = json['IsCorrect'];
    questionId = json['QuestionId'];
    question = json['Question'] != null ? new Question.fromJson(json['Question']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Text'] = this.text;
    data['IsCorrect'] = this.isCorrect;
    data['QuestionId'] = this.questionId;
    if (this.question != null) {
      data['Question'] = this.question!.toJson();
    }
    return data;
  }
}


