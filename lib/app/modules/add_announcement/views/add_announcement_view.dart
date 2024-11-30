import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/common/multi_select_dropdown.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import '../controllers/add_announcement_controller.dart';


class AddAnnouncementView extends GetView<AddAnnouncementController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading,
          child: Column(
            children: [
              BasicAppBar(
                title: 'Add Announcement'.tr,
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        child: BasicButton(
                          label: 'Save'.tr,
                          onPresed: controller.submit,
                        ),
                      ),
                      SizedBox(height: 16),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            /* BasicDropdown<ClassModel>(
                              items: controller.authController.availableClasses,
                              value: controller.selectedClass,
                              onChanged: (ClassModel? value) {
                                controller.selectedClass = value;
                              },
                              builder: (ClassModel value) => Text(value.name!),
                              validator: (ClassModel? value) {
                                if (value == null) {
                                  return "Please select class".tr;
                                }

                                return null;
                              },
                            ), */

                            BasicTextField(
                              controller: controller.classes,
                              readOnly: true,
                              hintText: 'Select classes'.tr,
                              labelText: 'Select classes'.tr,
                              onTap: () async {
                                final result = await showDialog<List<ClassModel>>(
                                  context: context,
                                  builder: (context) {
                                    return CustomMultiselectDropDown<ClassModel>(
                                      title: 'Select classes'.tr,
                                      items: controller.authController.availableClasses,
                                      selectedItems: controller.selected,
                                      onChanged: (List<ClassModel> values) {
                                        controller.selected = values;
                                      },
                                      builder: (context, index) => Text('${controller.authController.availableClasses.elementAt(index).name}',
                                      ),
                                    );
                                  },
                                );
                                if (result != null) {
                                  controller.selected = result;
                                }
                              },
                            ),
                            SizedBox(height: 16),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              runAlignment: WrapAlignment.start,
                              alignment: WrapAlignment.start,
                              spacing: 8,
                              direction: Axis.horizontal,
                              children: controller.selected
                                  .map((e) => Container(
                                        child: Chip(
                                          backgroundColor: kMainColor,
                                          label: Text(
                                            '${e.name}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(height: 16),
                            BasicTextField(
                              controller: controller.titleController,
                              hintText: 'Announcement Title'.tr,
                              labelText: 'Announcement Title'.tr,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select announcement title".tr;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            BasicTextField(
                              controller: controller.dateController,
                              hintText: 'Announcement Date'.tr,
                              labelText: 'Announcement Date'.tr,
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please pick announcement date".tr;
                                }
                                return null;
                              },
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: controller.selectedDate,
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  locale: Get.locale!,
                                );
                                if (date != null) {
                                  controller.selectedDate = date;
                                  controller.dateController.text = DateFormat(
                                          'yyyy MMM, dd',
                                          Get.locale!.languageCode)
                                      .format(date);
                                }
                              },
                            ),

                            SizedBox(height: 16),
                            BasicTextField(
                              controller: controller.timeController,
                              hintText: 'Announcement Time'.tr,
                              labelText: 'Announcement Time'.tr,
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please pick announcement Time".tr;
                                }
                                return null;
                              },
                              onTap: () async {
                                final time = await showTimePicker(
                                    context: context,
                                    initialTime:TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
                                if (time != null) {
                                 controller.selectedDate =DateTime(
                                     controller.selectedDate.year,
                                     controller.selectedDate.month,
                                     controller.selectedDate.day,
                                     time.hour,
                                     time.minute
                                 ) ;
                                 controller.timeController.text=
                                     DateFormat(
                                         'hh:mm a',
                                         Get.locale!.languageCode)
                                         .format(DateTime(
                                         controller.selectedDate.year,
                                         controller.selectedDate.month,
                                         controller.selectedDate.day,
                                         time.hour,
                                         time.minute
                                     ));}
                              },
                            ),

                            SizedBox(height: 16),
                            Card(
                              child: HtmlEditor(
                                controller: controller.bodyController,
                                htmlEditorOptions: HtmlEditorOptions(
                                  hint: 'Announcement body'.tr,
                                  autoAdjustHeight: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
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
