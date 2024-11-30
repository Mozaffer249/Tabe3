// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/conversation_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/chat_provider.dart';
import 'package:tabee3_flutter/app/utils/file_utils.dart';

class StartChatController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController textController = TextEditingController();

  ScrollController scrollController = ScrollController();

  Rxn<Conversation> _conversation = Rxn<Conversation>();
  Conversation? get conversation => _conversation.value;

  final RxList<Message> _messages = <Message>[].obs;
  List<Message> get messages => _messages.value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final firstUnreadMsg = 0.obs, unreadMsgCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      _conversation.value = Get.arguments as Conversation;
      if (_conversation.value!.threadId != null) {
        getMessages();
        markAsRead();
      }
    }
  }

  Future<void> getMessages() async {
    final request = {
      "customer_id": authController.currentUser!.id,
      "thread_id": _conversation.value!.threadId,
    };
    _isLoading(true);
    final result = await ChatProivder.getMessages(request);
    _isLoading(false);
    result.fold(
      (l) {
        _messages(l);
        _messages.sort((a, b) => b.time!.compareTo(a.time!));
        _messages.refresh();
        for (var i = 0; i < _messages.length; i++) {
          final element = _messages.value.elementAt(i);
          if (element.from == authController.currentUser!.id &&
              !element.readed) {
            unreadMsgCount.value++;
            if (firstUnreadMsg.value == 0) {
              firstUnreadMsg.value = i;
            }
          }
        }
         log('Un-read: ${unreadMsgCount.value}');
      },
      (r) => null,
    );
  }

  Future<void> sendMessage(dynamic value) async {
    int to;
    if (_conversation.value!.listMsg!.last.from ==
        authController.currentUser!.id) {
      to = _conversation.value!.listMsg!.last.to!;
    }
    else {
      to = _conversation.value!.listMsg!.last.from!;
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

    _messages.insert(0, message);
    _messages.refresh();
    textController.clear();
    Timer(Duration(milliseconds: 300), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    final Either<bool, String> result =
        await ChatProivder.sendMessage(message.toJson());
    _messages.elementAt(0).sending = false;
     _messages.refresh();
    result.fold(
      (l) => null,
      (r) {
        _messages.removeAt(0);
        _messages.refresh();
      },
    );
  }

  void sendImageMessage() async {
    final image = await pickFile(Get.overlayContext!);
    if (image == null) {
      return;
    }
    await sendMessage(image);
  }

  Future<void> markAsRead() async {
    final Either<bool, String> result = await ChatProivder.markAsRead(
        authController.currentUser!.id!, conversation!.threadId!);
    result.fold((l) => null, (r) => null);
  }

  @override
  void onClose() {}
}
