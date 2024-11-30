import 'package:tabee3_flutter/app/data/models/question.dart';

class Answer {
  int? id;
  String? answer;
  bool? isCorrect;
  int? questionId;
  Question? question;

  Answer({this.id, this.answer, this.isCorrect, this.questionId, this.question});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answer = json['answer'];
    isCorrect = json['isCorrect'];
    questionId = json['questionId'];
    question = json['question'] != null ? new Question.fromJson(json['question']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answer'] = this.answer;
    data['isCorrect'] = this.isCorrect;
    data['questionId'] = this.questionId;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    return data;
  }
}


