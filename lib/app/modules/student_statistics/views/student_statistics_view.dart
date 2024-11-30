import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_avatar.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';

import '../controllers/student_statistics_controller.dart';

class StudentStatisticsView extends GetView<StudentStatisticsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            BasicAppBar(
              title: controller.student.studentName!,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student'.tr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 180,
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(top: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFF8F8F8F).withOpacity(.13),
                            ),
                            child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: controller.currentTab == 0
                                            ? secondaryAppColor
                                            : Colors.transparent,
                                      ),
                                      child: Text(
                                        'exams'.tr,
                                        style: TextStyle(
                                          color: controller.currentTab == 0
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  /*   Expanded(
                                    child: InkResponse(
                                      onTap: () {
                                        controller.currentTab = 1;
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: controller.currentTab == 1
                                              ? secondaryAppColor
                                              : Colors.transparent,
                                        ),
                                        child: Text(
                                          'Year Works'.tr,
                                          style: TextStyle(
                                            color: controller.currentTab == 1
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                 */
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -2),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BasicAvatarImage(
                                    width: 80,
                                    height: 80,
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1547082661-71362fc3969c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2064&q=80',
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${controller.student.studentName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.black,
                                          fontFamily: 'Cairo',
                                      fontWeight: FontWeight.normal
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    IndexedStack(
                      index: controller.currentTab,
                      children: [
                        _buildStudentExams(),
                        // _buildStudentYearWorks(),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStudentExams() {
    return ListView.separated(
      itemCount: controller.results.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        final result = controller.results.elementAt(index);
        return ListTile(
          title: Text(
            result.subject!.name!,
            style: Get.theme.textTheme.bodyLarge!.copyWith(
              fontSize: 18,
            ),
          ),
          trailing: Text(
            "${result.obtainMarks}",
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 8);
      },
    );
  }
}
