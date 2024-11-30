import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/modules/subject/views/subject_attendance_view.dart';
import 'package:tabee3_flutter/app/modules/subject/views/subject_lectures_view.dart';
import 'package:tabee3_flutter/app/modules/subject/views/subject_results_view.dart';

import '../controllers/subject_controller.dart';

class SubjectView extends GetView<SubjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: controller.subject.name!,
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.loadData,
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 18,
                right: 18,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 360,
                          decoration: BoxDecoration(
                            color: Color(0xff00CDDA),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage('assets/images/Ellipse5.png'),
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "${controller.subject.name}".tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              DefaultTabController(
                                length: 3,
                                child: TabBar(
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.white,
                                  indicatorColor: Colors.white,
                                  indicatorWeight: 5,
                                  onTap: (index) {
                                    controller.currentTab = index;
                                  },
                                  tabs: [
                                    Tab(
                                      text: "lesson".tr,
                                    ),
                                    Tab(
                                      text: "theAudience".tr,
                                    ),
                                    Tab(
                                      text: "theExams".tr,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        color: Colors.white,
                        child: IndexedStack(
                          index: controller.currentTab,
                          children: [
                            SubjectLecturesView(),
                            SubjectAttendanceView(),
                            SubjectResultsView(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -.90),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: controller.subject.image!,
                          height: 50,
                          width: 50,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
