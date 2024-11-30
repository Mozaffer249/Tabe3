import 'package:flutter/material.dart';

import 'package:get/get.dart';
 
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';

import '../controllers/exam_controller.dart';

class ExamView extends GetView<ExamController> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          BasicAppBar(title: 'theExams'.tr),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 280,
            height: 50,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 237, 236, 236),
                    blurRadius: 5.0,
                    spreadRadius: 2,
                    offset: Offset(0, 8),
                  ),
                ],
                // border: Border.all(width: 0.8),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
            child: Obx(
              ()=> ListTile(
                leading: Text(
                  "${controller.exam_val}",
                  style: TextStyle(
                    // color: Color.fromARGB(18, 171, 169, 169),
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                trailing: buildSemester123(),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                buildTest(
                  "Test1".tr,
                  "10/9",
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  height: screenHeight * 0.005,
                  decoration: BoxDecoration(
                    color: Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                buildTest("Test2".tr, "20/7"),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  height: screenHeight * 0.005,
                  decoration: BoxDecoration(
                    color: Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                buildTest("Test3".tr, "30/27"),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  height: screenHeight * 0.005,
                  decoration: BoxDecoration(
                    color: Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                buildTest("semesterExam".tr, "100/95"),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  height: screenHeight * 0.005,
                  decoration: BoxDecoration(
                    color: Color(0xffE0E0E0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 110,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 43,
                          width: 165,
                          decoration: BoxDecoration(
                            color: Color(0xff00CDDA),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "downloadTheResult".tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18 ,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 43,
                          width: 165,
                          decoration: BoxDecoration(
                            color: Color(0xff00CDDA),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "printTheResult".tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18 ,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
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
            fontSize: 15 ,
          ),
        ),
        Text(
          result,
          style: TextStyle(
            color: Color(0xff585858),
            fontSize: 15 ,
          ),
        ),
      ],
    );
  }

  Widget buildSemester123() {
    final List<String> _levels = [
      // "اختار المادة",
      'الكيمياء',
      'الفيزياء',
      'العلوم',
      'رياضيات',
      'احياء',
    ];
    return PopupMenuButton(
      initialValue: controller.exam_val!.value,
      itemBuilder: (context) => _levels
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: Text(
                '$e',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          )
          .toList(),
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 20.0,
        color: Color.fromARGB(255, 211, 205, 205),
      ),
      onSelected: (String value){
        print(value);
        controller.exam_val!.value = value;
      },
    );
  }
}
