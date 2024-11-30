import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/conversation_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/modules/chat/controllers/chat_controller.dart';
import 'package:tabee3_flutter/app/utils/file_utils.dart';

import '../../../providers/chat_provider.dart';

class MultiMessageController extends GetxController
{

  final AuthController authController = Get.find<AuthController>();
  ChatController chatController=Get.find<ChatController>();

  ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  final RxList<Message> _messages = <Message>[].obs;
  List<Message> get messages => _messages.value;
  final firstUnreadMsg = 0.obs, unreadMsgCount = 0.obs;

  List<Conversation> _conversation = <Conversation>[];
  List<Conversation> get conversation => _conversation;

  late List<int>  _reciverIds=<int>[].obs;
  List<int> get reciverIds => _reciverIds;

  bool? _isFromNewChat;
  bool? get isFromNewChat => _isFromNewChat;
  dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    _isFromNewChat = argumentData[1]  ;

    if(argumentData != null && !_isFromNewChat!)
      {
        _conversation=argumentData[0];
        print(_conversation.length);
      }
    else if(argumentData != null && _isFromNewChat!)
        {
          _reciverIds=Get.arguments[0];
          print(_reciverIds.length);

        }
  }

  Future<void> sendMessage(dynamic value,bool isLast,Conversation conversation) async {
    int to;
    if (conversation.listMsg!.last.from ==
        authController.currentUser!.id) {
      to = conversation.listMsg!.last.to!;
    }
    else {
      to = conversation.listMsg!.last.from!;
    }
    Message message = Message(
      from: authController.currentUser!.id,
      to: to,
      readed: true,
      time: DateTime.now(),
      sending: true,
    );
    if (value is String) {
      message = message.copyWith(
        msgType: 0,
        msg: value,
      );
      /* message = Message(
        from: authController.currentUser!.id,
        to: to,
        readed: true,
        msg: value,
        msgType: 0,
        time: DateTime.now(),
        sending: true,
      ); */

    } else if (value is File) {
      final image = await getFileBase64(value);
      message = message.copyWith(
        msg: 'Photo',
        image: image,
        msgType: 1,
        uploadedImage: value,
      );
    }

    if(isLast){
      _messages.insert(0, message);
      _messages.refresh();
      textController.clear();
    }

    Timer(Duration(milliseconds: 300), () {scrollController.jumpTo(scrollController.position.maxScrollExtent);});
    final Either<bool, String> result = await ChatProivder.sendMessage(message.toJson());
   _conversation.remove(conversation);

    if(isLast){
      _messages.elementAt(0).sending = false;
      _messages.refresh();
    }

    if(isLast){
      result.fold(
            (l) => null,
            (r) {
          _messages.removeAt(0);
          _messages.refresh();
        },
      );
    }

  }

  void sendImageMessage() async {
    final image = await pickFile(Get.overlayContext!);
    if (image == null) {
      return;
    }
       for(var receiver in conversation ){
         sendMessage(
             image,
             receiver==_conversation.last ?true:false,
             receiver);
    }
  }



  Future<void> sendMessageFromNewChat(dynamic value,bool isLast,to) async {

    Message message = Message(
      from: authController.currentUser!.id,
      to: to,
      readed: true,
      time: DateTime.now(),
      sending: true,
    );
    if (value is String) {
      message = message.copyWith(
        msgType: 0,
        msg: value,
      );

    } else if (value is File) {
      final image = await getFileBase64(value);
      message = message.copyWith(
        msg: 'Photo',
        image: image,
        msgType: 1,
        uploadedImage: value,
      );
    }

    if(isLast){
      _messages.insert(0, message);
      _messages.refresh();
      textController.clear();
    }

    Timer(Duration(milliseconds: 300), () {scrollController.jumpTo(scrollController.position.maxScrollExtent);});
    final Either<bool, String> result = await ChatProivder.sendMessage(message.toJson());
    _conversation.remove(conversation);

    if(isLast){
      _messages.elementAt(0).sending = false;
      _messages.refresh();
    }

    if(isLast){
      result.fold(
            (l) => null,
            (r) {
          _messages.removeAt(0);
          _messages.refresh();
        },
      );
    }

  }
  void sendImageMessageForFromNew() async {
    final image = await pickFile(Get.overlayContext!);
    if (image == null) {
      return;
    }
    for(var receiver in reciverIds ){
      sendMessageFromNewChat(
          image,
          receiver==reciverIds.last ?true:false,
          receiver);
    }
  }

}