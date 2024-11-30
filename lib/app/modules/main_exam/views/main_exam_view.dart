import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controllers/main_exam_controller.dart';

class MainExamView extends GetView<MainExamController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          BasicAppBar(title: 'theExams'.tr),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 237, 236, 236),
                  blurRadius: 5.0,
                  spreadRadius: 2,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      "اختيار المادة",
                      style: TextStyle(
                        color: Color.fromARGB(255, 171, 169, 169),
                      ),
                    ),
                  ),
                  //     PopupMenuButton(
                  //   itemBuilder: (context) => controller.students.value
                  //       .map(
                  //         (e) => PopupMenuItem(
                  //           value: e,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 '${e.studentName}',
                  //                 style: const TextStyle(fontSize: 18.0),
                  //               ),
                  //               Text(
                  //                 '${e.studentClass}',
                  //                 style: const TextStyle(fontSize: 18.0),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),

                  //   icon: const Icon(Icons.arrow_back_ios,
                  //       size: 20.0, color: Colors.white),
                  // )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            height: 370,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white12,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                // BoxShadow(
                //   color: Color.fromARGB(255, 237, 236, 236),
                //   blurRadius: 5.0,
                //   spreadRadius: 2,
                //   offset: Offset(0, 8),
                // ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => buildContainer(),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildContainer() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(Routes.EXAM);
          },
          child: Container(
            height: 55,
            width: 270,
            // color: Colors.grey[300],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    "physics".tr,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(height: 3, color: Colors.grey[300])
      ],
    );
  }

  Row buildTest(String test, String result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          test,
          style: TextStyle(
            color: Color(0xff585858),
            fontSize: 15,
          ),
        ),
        Text(
          result,
          style: TextStyle(
            color: Color(0xff585858),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
