import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/common/pdfapi.dart';
import 'package:tabee3_flutter/app/data/common/pdfinvoiceapi.dart';
import 'package:tabee3_flutter/app/data/models/exams_model.dart';
import 'package:tabee3_flutter/app/data/models/pdf/customer.dart';
import 'package:tabee3_flutter/app/data/models/pdf/invoice.dart';
import 'package:tabee3_flutter/app/data/models/pdf/supplier.dart';
import 'package:tabee3_flutter/app/data/models/result_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/utils/file_utils.dart';
import 'package:http/http.dart' as http;

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        appBar: BasicAppBar(title: 'results'.tr),
        body: LoadingOverlay(
          isLoading: controller.isSharing,
          child: controller.isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 24),
                      Container(
                        child: Column(
                          children: [
                            BasicDropdown<ExamModel>(
                              items: controller.exams,
                              hintText: 'Select exam'.tr,
                              value: controller.selectedExam,
                              onChanged: (value) {
                                controller.selectedExam = value;
                                controller.getResult();
                              },
                              builder: (item) {
                                return Text(item.name!);
                              },
                            ),
                            SizedBox(height: 24),
                            if (controller.isLoadingResult)
                              Container(
                                height: 300,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            else if (controller.results.isEmpty)
                              Container(
                                height: 500,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.list_alt,
                                        size: 40,
                                      ),
                                      SizedBox(height: 16),
                                      Text('No result'.tr),
                                    ],
                                  ),
                                ),
                              )
                            else
                              Column(
                                children: [
                                  Screenshot(
                                    controller: controller.screenshotController,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: size.height*.2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("بسم الله الرحمن الرحيم", style:TextStyle(fontSize: 12,) ,)
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.all(size.width*.02),
                                                          decoration: BoxDecoration(
                                                              // color: Colors.black,
                                                              borderRadius: BorderRadius.circular(4),
                                                            border: Border.all(color: Colors.black54)
                                                          ),
                                                          height: size.height*.1,
                                                          width: size.width*.3,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text("وزارة التربية والتعليم",
                                                                style:TextStyle(fontSize: 9) ,),
                                                              Text("ولاية الخرطوم",
                                                                style:TextStyle(fontSize: 9) ,),
                                                              // Text("محلية شرق النيل",
                                                              //   style:TextStyle(fontSize: 9) ,),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: size.height*.15,
                                                      width:  size.width*.2,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(12),
                                                        child: CachedNetworkImage(
                                                          // fit: BoxFit.cover,
                                                          //  imageUrl: "http://tabee-edu.com:8069/web/image?model=res.users&id=15385&field=image_medium&unique=",
                                                          imageUrl: controller.grade!.image!,
                                                          // height: size.height*.45,
                                                          // width:  size.width*.2,
                                                          placeholder: (context, url) => Image.asset(
                                                            'assets/images/loading.gif',
                                                            fit: BoxFit.cover,
                                                          ),
                                                          errorWidget: (context, url, error) {
                                                            print(error.toString());
                                                         return    const Icon(
                                                                Icons.error);
                                                          },
                                                        ),
                                                      ),
                                                    ),


                                                    Row(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.all(size.width*.02),
                                                          decoration: BoxDecoration(
                                                              // color: Colors.,
                                                              borderRadius: BorderRadius.circular(4),
                                                              border: Border.all(color: Colors.black54)
                                                          ),
                                                          height: size.height*.1,
                                                          width: size.width*.3,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text("ادارة التعليم الخاص",
                                                                style:TextStyle(fontSize: 9) ,),
                                                              Text("نتيجة امتحان",
                                                                style:TextStyle(fontSize: 9) ,),
                                                              Text(controller.homeController.student.value!.studentClass!,
                                                                style:TextStyle(fontSize: 9) ,),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                ],),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: size.height*.02),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.black54)
                                            ),
                                            height: size.height*.2,
                                            width: size.width,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(controller.homeController.authController.currentUser!.schoolName!, style: TextStyle(fontSize: 12)),
                                                Text(controller.selectedExam!.name!, style: TextStyle(fontSize: 12)),

                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              child: Row(
                                                                children: [
                                                                  Text("Studen Name".tr+" : ", style: TextStyle(fontSize: 14)),
                                                                  Text("${controller.homeController.student.value!.studentName}", style: TextStyle(fontSize: 14)),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                              child: Row(
                                                                children: [
                                                                  Text("Percentage".tr+" : ", style: TextStyle(fontSize: 14)),
                                                                  Text( '${controller.grade!.percentage}%', style: TextStyle(fontSize: 14)),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                              child: Row(
                                                                children: [
                                                                  Text("Grade".tr+" : ", style: TextStyle(fontSize: 14)),
                                                                  Text("${controller.grade!.grade}", style: TextStyle(fontSize: 14)),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Table(
                                            border: TableBorder.all(
                                                color: Color(0xFFC4C4C4)),
                                            children: <TableRow>[
                                              TableRow(
                                                decoration: BoxDecoration(color: kMainColor),
                                                children: <Widget>[
                                                  buildTitleText(
                                                    'subject'.tr,
                                                    whiteColor: true,
                                                  ),
                                                  buildTitleText(
                                                    'topClass'.tr,
                                                    whiteColor: true,
                                                  ),
                                                  buildTitleText(
                                                    'lowerClass'.tr,
                                                    whiteColor: true,
                                                  ),
                                                  buildTitleText(
                                                    'obtained'.tr,
                                                    whiteColor: true,
                                                  ),
                                                ],
                                              ),
                                              ...controller.results
                                                  .asMap()
                                                  .map((int key,
                                                          Result value) =>
                                                      MapEntry(
                                                          key,
                                                          TableRow(
                                                            // decoration:
                                                            //     BoxDecoration(color: Color(0xFF00BAC642)),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: key % 2 !=
                                                                      0
                                                                  ? kMainColor.withOpacity(.3)
                                                                  : Colors.transparent,
                                                            ),
                                                            children: <Widget>[
                                                              buildTitleText(
                                                                '${value.subject!}',
                                                                whiteColor:
                                                                    false,
                                                              ),
                                                              buildTitleText(
                                                                '${value.maximumMarks!}',
                                                                whiteColor:
                                                                    false,
                                                              ),
                                                              buildTitleText(
                                                                '${value.minimumMarks!}',
                                                                whiteColor:
                                                                    false,
                                                              ),
                                                              buildTitleText(
                                                                '${value.obtainedMarks!}',
                                                                whiteColor:
                                                                    false,
                                                              ),
                                                            ],
                                                          )))
                                                  .values
                                                  .toList()
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 15.0,
                                    ),
                                    child: BasicButton(
                                      onPresed:()async{

                                        final pdfFile = await PdfInvoiceApi.generate(
                                            result: controller.grade!,
                                            size: size,
                                          className:controller.homeController.student.value!.studentClass! ,
                                          schoolName: controller.homeController.authController.currentUser!.schoolName!,
                                          examName: controller.selectedExam!.name!,
                                          resultsList: controller.results,
                                          studentName: controller.homeController.student.value!.studentName!,
                                        );
                                          // controller.downloadResult(pdfFile);
                                           PdfApi.openFile(pdfFile);
                                        //  controller.captureAndSharePng();

                                      },
                                      label: 'downloadTheResult'.tr,
                                      verticalPadding: 10.0,
                                    ),
                                  ),


                                ],
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildStudentRow(Student student) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.grey.shade300,
      elevation: 3,
      child: ListTile(
        title: Text('${student.studentName}'),
        subtitle: Text('${student.studentClass}'),
        leading: Icon(
          Icons.circle_outlined,
          color: secondaryAppColor,
          size: 50.0,
        ),
      ),
    );
  }

  Row _buildSummaryRow(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: Get.theme.textTheme.bodyMedium,
        ),
        Spacer(),
        Text(
          value,
          style: Get.theme.textTheme.bodyLarge!.copyWith(color: kMainColor),

        ),
      ],
    );
  }
  final headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'
  };

  // final response = await http.get(Uri.parse('http://tabee-edu.com:8069/web/image/res.company/72/logo'), headers: headers);

  Widget buildTitleText(String text, {required bool whiteColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: whiteColor ? Colors.white : Colors.black,
          fontWeight: FontWeight.normal,

        ),
      ),
    );
  }



}
