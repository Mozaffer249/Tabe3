import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/bubble.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/conversation_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controllers/start_chat_controller.dart';

// ignore: must_be_immutable
class StartChatView extends GetView<StartChatController> {
  BubbleStyle? styleSomebody, styleMe;
  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;
    styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Color(0xFFE9E9E9),
      elevation: 3 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0, left: 8.0),
      alignment: Alignment.topLeft,
    );

    styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color(0xFF00BAC6),
      elevation: 3 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0, right: 8.0),
      alignment: Alignment.topRight,
    );

    return Scaffold(
      appBar: BasicAppBar(
        title: controller.conversation!.threadName!,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                child: ListView.separated(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (ctx, index) {
                    final msg = controller.messages[index];
                    return buildMessageRow(msg);
                  },
                  separatorBuilder: (ctx, index) {
                    final msg = controller.messages[index];
                    if (index == controller.messages.length) {
                      return SizedBox(
                        height: 64.0,
                      );
                    }
                    if (index == controller.firstUnreadMsg.value &&
                        msg.from !=
                            controller.authController.currentUser!.id &&
                        controller.unreadMsgCount.value > 0) {
                      return Container(
                        color: Theme.of(context).primaryColor.withOpacity(.1),
                        child: Bubble(
                          alignment: Alignment.center,
                          color: Colors.white,
                          elevation: 1 * px,
                          //                                            margin: BubbleEdges.only(top: 8.0),
                          radius: Radius.circular(30),
                          child: Text(
                            "Unread messages".trParams(
                              <String, String>{
                                'count':
                                    controller.unreadMsgCount.value.toString()
                              },
                            ),
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                  itemCount: controller.messages.length,
                ),
              ),
              // const Divider(height: 1.0),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFEEEEEE),
                ),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessageRow(Message chat) {
    bool isMe = chat.from.toString() ==
        controller.authController.currentUser!.id.toString();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Bubble(
          style: isMe ? styleMe : styleSomebody,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (chat.msgType == 0)
                Text(
                  chat.msg!,
                  style: TextStyle(
                    color: isMe ? Colors.white : Color(0xFF484848),
                    fontFamily: 'Cairo',
                    fontSize: 14,
                  ),
                )
              else if (chat.uploadedImage != null)
                Image.file(
                  chat.uploadedImage!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                )
              else
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      Routes.IMAGE_VIEWER,
                      arguments: {
                        'imageUrl': chat.image,
                        'title': controller.conversation!.threadName,
                      },
                    );
                  },
                  child: Hero(
                    tag: chat.image!,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: chat.image!,
                      width: 300,
                      height: 300,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error){
                        print(error);
                      return  const Icon(Icons.error);
    }

                    ),
                  ),
                ),

              // SizedBox(height: 4),
              /*   Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  isMe
                      ? chat.sending
                          ? Container(
                              margin: Get.locale!.languageCode == 'ar'
                                  ? const EdgeInsets.only()
                                  : const EdgeInsets.only(),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 15,
                              ),
                            )
                          : chat.error
                              ? Container(
                                  margin: Get.locale!.languageCode == 'ar'
                                      ? const EdgeInsets.only()
                                      : const EdgeInsets.only(),
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 15,
                                  ),
                                )
                              : chat.readed
                                  ? Container(
                                      margin: Get.locale!.languageCode == 'ar'
                                          ? const EdgeInsets.only(left: 4.0)
                                          : const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.check,
                                        color: Get.theme.primaryColor,
                                        size: 15,
                                      ),
                                    )
                                  : Container(
                                      margin: Get.locale!.languageCode == 'ar'
                                          ? const EdgeInsets.only()
                                          : const EdgeInsets.only(),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                    )
                      : Container(),
                ],
              ), */
            ],
          ),
//      time: chat.time!.toString(),
        ),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            SizedBox(width: 16),
            Text(
              DateFormat('hh:mm a', Get.locale!.languageCode)
                  .format(chat.time!),
              style: TextStyle(
                color: Color(0xFF9A9696),
                fontFamily: 'Cairo',
                fontSize: 10,
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.textController,
              onSubmitted: controller.sendMessage,
              onChanged: (text) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message'.tr,
                hintStyle: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: controller.sendImageMessage,
          icon: Icon(
            Icons.photo,
            color: kMainColor,
          ),
        ),
        IconButton(
          onPressed: () {
            if (controller.textController.text.isNotEmpty) {
              controller.sendMessage(controller.textController.text);
            }
          },
          icon: SvgPicture.asset('assets/svg/send.svg'),
        ),
      ],
    );
  }
}
