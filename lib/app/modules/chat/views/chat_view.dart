import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/conversation_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isDeletingThread,
        child: Scaffold(
          appBar: BasicAppBar(
              title: "conversations",
          actions: [
          controller.receiverConvs.length>1?  Container(
              margin: EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: (){
                  controller.goToMultiMessage();
                },
                child: Row(
                  children: [
                    Text("Multi Message".tr,
                      style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),),
                    SizedBox(width: 5,),
                    Icon(
                      Icons.chat_bubble,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ],
                ),
              ),
            ):Container()
          ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.NEW_CHAT);
            },
            child: Icon(Icons.chat_bubble),
            backgroundColor: kMainColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              onRefresh: controller.getConversations,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10),
                  if (controller.isLoading)
                    Container(
                      height: 600,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (controller.conversations.isEmpty)
                    Container(
                      height: 600,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/chat.svg',
                              color: kMainColor,
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(height: 16),
                            Text('No data'.tr),
                          ],
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.conversations.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final convo = controller.conversations.elementAt(index);
                        return _buildMessageRow(convo);
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageRow(Conversation conversation) {
    int unreadedCount = conversation.listMsg!.where((element) =>
            element.to == controller.authController.currentUser!.id &&
            !element.readed)
        .length;
    return Slidable(
      startActionPane: ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            controller.deleteConversation(conversation.threadId!);
          },
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'delete'.tr,
        ),
      ]),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color:conversation.isSelected ? Colors.amber : Colors.white,
        ),
        child: ListTile(
          onLongPress: (){
         controller.receiverConvs.length>0?{}: controller.onLongTapListItem(conversation);
            },
          onTap: () async {
            if(controller.isSelectingActive){
              controller.onLongTapListItem(conversation);
            }
            else
              {
                Get.toNamed(Routes.START_CHAT, arguments: conversation);
                controller.getConversations();
              }

          },
          selected:conversation.isSelected,
          leading: Icon(
            Icons.circle_outlined,
            color: secondaryAppColor,
            size: 50.0,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (unreadedCount > 0)
                CircleAvatar(
                  radius: 13.0,
                  backgroundColor: kMainColor,
                  child: Text(
                    '$unreadedCount',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              Text(
                timeago.format(
                  conversation.listMsg!.first.time!,
                  locale: Get.locale!.languageCode,
                ),
                style: TextStyle(
                  fontSize: 10.0,
                  color: Color(0xFF9A9696),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          title: Align(
            alignment: Alignment.topRight,
            child: Text(
              conversation.threadName!,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Align(
            alignment: Alignment.topRight,
            child: Row(
              children: [
                if (conversation.listMsg!.first.msg == 'Photo')
                  Icon(
                    Icons.photo,
                    color: kMainColor,
                    size: 18,
                  ),
                if (conversation.listMsg!.first.msg == 'Photo')
                  SizedBox(width: 8),
                Text(
                  conversation.listMsg!.first.msg!,
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
