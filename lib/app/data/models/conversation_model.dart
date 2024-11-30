// To parse this JSON data, do
//
//     final conversation = conversationFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

Conversation conversationFromJson(String str) =>
    Conversation.fromJson(json.decode(str));

String conversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
  Conversation({
    this.threadName,
    this.threadId,
    this.listMsg,
    this.status,
  });

  final String? threadName;
  final int? threadId;
  final List<Message>? listMsg;
  final int? status;
  bool isSelected = false;

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        threadName: json["thread_name"] == null || json["thread_name"] is bool
            ? ''
            : json["thread_name"],
        threadId: json["thread_id"] == null ? null : json["thread_id"],
        listMsg: json["list_msg"] == null
            ? null
            : List<Message>.from(
                json["list_msg"].map((x) => Message.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "thread_name": threadName == null ? null : threadName,
        "thread_id": threadId == null ? null : threadId,
        "list_msg": listMsg == null
            ? null
            : List<dynamic>.from(listMsg!.map((x) => x.toJson())),
        "status": status == null ? null : status,
      };
}

class Message {
  Message({
    this.id,
    this.msg,
    this.msgType,
    this.image,
    this.time,
    this.from,
    this.to,
    this.readed = true,
    this.sending = false,
    this.error = false,
    this.uploadedImage,
  });

  final int? id;
  final String? msg;
  final String? image;
  final int? msgType;
  final DateTime? time;
  final int? from;
  final int? to;
  bool readed;
  bool sending;
  bool error;
  File? uploadedImage;

  Message copyWith({
    DateTime? time,
    int? from,
    String? image,
    bool? readed,
    int? id,
    int? to,
    int? msgType,
    String? msg,
    File? uploadedImage,
  }) =>
      Message(
        time: time ?? this.time,
        from: from ?? this.from,
        image: image ?? this.image,
        readed: readed ?? this.readed,
        id: id ?? this.id,
        to: to ?? this.to,
        msgType: msgType ?? this.msgType,
        msg: msg ?? this.msg,
        uploadedImage: uploadedImage ?? this.uploadedImage,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? null : json["id"],
        msg: json["msg"] == null ? null : json["msg"],
        msgType: json["msg_type"] == null ? null : json["msg_type"],
        image: json["image"] == null ? null : json["image"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        from: json["from"] == null ? null : json["from"],
        to: json["to"] == null || json["to"] is bool ? 0 : json["to"],
        readed: json["readed"] == null ? null : json["readed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "msg": msg == null ? null : msg,
        "msg_type": msgType == null ? null : msgType,
        "image": image == null ? null : image,
        "time": time == null ? null : time!.toIso8601String(),
        "from": from == null ? null : from,
        "to": to == null ? null : to,
        "readed": readed,
      };
}
