import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/subject/controllers/subject_controller.dart';

class SubjectResultsView extends GetView<SubjectController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.isLoadingResult)
            Container(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (controller.result.isEmpty)
            Container(
              height: 500,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No results for this subject'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView.separated(
                  itemCount: controller.result.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    final result = controller.result.elementAt(index);
                    return buildTest(
                      '${result.exam!.name}',
                      "${result.obtainMarks} / ${result.maximumMarks ?? 0.0}",
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: Color(0xffE0E0E0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                /* child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    buildTest(
                      "Test1".tr,
                      "10/9",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Color(0xffE0E0E0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    buildTest("Test2".tr, "20/7"),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Color(0xffE0E0E0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    buildTest("Test3".tr, "30/27"),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Color(0xffE0E0E0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    buildTest("semesterExam".tr, "100/95"),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Color(0xffE0E0E0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 16,
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
                                    fontSize: 18,
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
                                    fontSize: 18,
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
               */
              ),
            ),
        ],
      ),
    );
  }

  Widget buildTest(String test, String result) {
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
