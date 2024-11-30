import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/conversation_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/new_chat_controller.dart';

class NewChatView extends GetView<NewChatController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
    () =>Scaffold(
        appBar: BasicAppBar(
            title: 'Start new chat'.tr,
          actions: [
            controller.reciverIds.length > 1 ?  Container(
              margin: EdgeInsets.only(left: 20),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (controller.authController.currentUser!.userType ==
                            "T")
                          BasicDropdown<ClassModel>(
                            items: controller.authController.availableClasses,
                            labelText: 'Select class'.tr,
                            hintText: 'Select class'.tr,
                            value: controller.selectedClass,
                            onChanged: (ClassModel? value) {
                              controller.selectedClass = value;
                            },
                            builder: (ClassModel value) {
                              return Text(
                                value.name!,
                              );
                            },
                          ),
                        if (controller.isLoading)
                          Container(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (controller.authController.currentUser!.userType == "T")
                          ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: controller.students.length,
                            itemBuilder: (BuildContext context, int index) {
                              final student = controller.students.elementAt(index);
                              return Card(
                                child: Container(
                                   decoration:   BoxDecoration(
                                     borderRadius: BorderRadius.circular(15.0),
                                     color: student.isSelected ? Colors.amberAccent:Colors.white,
                                   ),
                                   child: ListTile(
                                    title: Text(
                                      "${student.parentName}",
                                    ),
                                    subtitle: Text(
                                      "Parent name".trParams({"name": student.name ?? '-'}),
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            Get.defaultDialog(
                                              title: "Call".tr,
                                              content: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  student.mobile==false  ||student.mobile ==null ?
                                                  Container(child: Text("No Phone".tr),) : GestureDetector(
                                                      onTap: ()async{
                                                        final tel = "tel:${student.mobile}";
                                                        if (await canLaunchUrlString(tel)) {
                                                          await launchUrlString(tel);
                                                        }
                                                      },
                                                      child: Text("${student.mobile}")
                                                  ),

                                                  Divider(),
                                                  student.phone == false ||  student.phone ==null ?
                                                  Container(child: Text("No Phone".tr),): GestureDetector(
                                                      onTap: ()async{
                                                        final tel = "tel:${student.phone}";
                                                        if (await canLaunchUrlString(tel)) {
                                                          await launchUrlString(tel);
                                                        }
                                                      },
                                                      child: Text("${student.phone}")
                                                  )
                                                ],
                                              )
                                            );

                                          },
                                          icon: Icon(
                                            Icons.call,
                                            color: kMainColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.offNamed(
                                              Routes.START_CHAT,
                                              arguments: Conversation(
                                                threadName: student.parentName,
                                                listMsg: [
                                                  Message(
                                                    to: student.parentId,
                                                    from: student.parentId,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.chat_bubble,
                                            color: kMainColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onLongPress: (){
                                      controller.reciverIds.length>0?{}:controller.onLongTapListItem(student.parentId!,student.isSelected );
                                    },
                                    onTap: (){
                                      if(controller.isSelectingActive)
                                        {
                                       controller.onLongTapListItem(student.parentId!,student.isSelected);
                                        }
                                    },
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                SizedBox(height: 8),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: controller.contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              final teahcer =
                                  controller.contacts.elementAt(index);
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    "${teahcer.customerName}",
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        Routes.START_CHAT,
                                        arguments: Conversation(
                                          threadName: '${teahcer.customerName}',
                                          listMsg: [
                                            Message(
                                              to: teahcer.customerId,
                                              from: teahcer.customerId,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.chat_bubble,
                                      color: kMainColor,
                                    ),
                                  ),


                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                SizedBox(height: 8),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
