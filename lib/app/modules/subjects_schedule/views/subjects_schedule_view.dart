import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';

import '../controllers/subjects_schedule_controller.dart';

class SubjectsScheduleView extends GetView<SubjectsScheduleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: "materialTable"),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.days
                            .map(
                              (e) => Container(
                                child: buildBox(e, 10),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 16),
                    if (controller
                        .lectures[controller.selectedDay.value]!.isNotEmpty)
                      Timeline.tileBuilder(
                        shrinkWrap: true,
                        primary: false,
                        theme: TimelineThemeData(
                          indicatorPosition: 0.5,
                          nodePosition: 0.2,
                          color: kMainColor,
                          connectorTheme:
                              ConnectorTheme.of(context).copyWith(thickness: 3),
                        ),
                        builder: TimelineTileBuilder.fromStyle(
                          contentsAlign: ContentsAlign.basic,
                          oppositeContentsBuilder:
                              (BuildContext context, int index) {
                            final lec = controller
                                .lectures[controller.selectedDay.value]![index];

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${lec.startTime}',
                                  style: TextStyle(
                                    color: Color(0xFF1D1D1D),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${lec.endTime}',
                                  style: TextStyle(
                                    color: Color(0xFF1D1D1D),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                          contentsBuilder: (BuildContext context, int index) {
                            final lec = controller
                                .lectures[controller.selectedDay.value]![index];
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: buildContainer(
                                lec.subjectName!,
                                Colors.pink,
                                '${lec.image}',
                                lec.teacher!,
                              ),
                            );
                          },
                          itemCount: controller
                              .lectures[controller.selectedDay.value]!.length,
                        ),
                      )
                    else
                      Container(
                        height: 300,
                        child: Center(
                          child: Text('No data'.tr),
                        ),
                      ),
                    /*  Row(
                  children: [
              buildTime("7.30", "8.30"),
              /* Container(
                height: 60,
                width: 70,
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(top: 5, child: Text("6.00")),
                    Positioned(top: 20, child: Text("7.00")),
                    Positioned(
                      top: 15,
                      left: 11,
                      child: Container(
                        color: Color(0xFF29C5CF),
                        height: 60,
                        width: 7,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 4,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Color(0xFF29C5CF),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
               */
              Expanded(
                  child: buildContainer("physics", Colors.pink, "atom1")),
                  ],
                ),
                Row(
                  children: [
              buildTime("7.30", "8.30"),
              buildContainer("chemistry", Colors.blue, "atom2"),
                  ],
                ),
                Row(
                  children: [
              buildTime("9.00", "10.00"),
              buildContainer("mathematics", Colors.green, "atom3"),
                  ],
                ),
                Row(
                  children: [
              buildTime("10.30", "11.00"),
              buildContainer("geography", Colors.red, "atom4"),
                  ],
                ),
                Row(
                  children: [
              buildTime("11.30", "12.00"),
              buildContainer("physics", Colors.pink, "atom1"),
                  ],
                ),
                Row(
                  children: [
              Container(
                height: 60,
                width: 70,
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(top: 5, child: Text("12.30")),
                    Positioned(top: 20, child: Text("1.00")),
                    Positioned(
                      // top: 15,
                      left: 11,
                      child: Container(
                        color: Color(0xFF29C5CF),
                        height: 20,
                        width: 7,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 4,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Color(0xFF29C5CF),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
              buildContainer("chemistry", Colors.blue, "atom2"),
                  ],
                ),
               */
                  ],
                ),
        ),
      ),
    );
  }

  Container buildTime(String time1, String time2) {
    return Container(
      height: 60,
      width: 70,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(top: 5, child: Text(time1)),
          Positioned(top: 20, child: Text(time2)),
          Positioned(
            left: 11,
            child: Container(
              color: Color(0xFF29C5CF),
              height: 100,
              width: 7,
            ),
          ),
          Positioned(
            top: 12,
            left: 4,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Color(0xFF29C5CF),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(
    String name,
    Color color,
    String image,
    String teacherName,
  ) {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: image,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.tr,
                        style: TextStyle(
                          color: Color(0xFF1D1D1D),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        teacherName,
                        style: TextStyle(
                          color: Color(0xFF1D1D1D),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBox(String day, int date) {
    return InkWell(
      onTap: () {
        controller.selectedDay.value = day;
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.all(10),
        duration: Duration(milliseconds: 400),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: day != controller.selectedDay.value
              ? Color(0x713A989F)
              : Color(0xFF3A999F),
        ),
        child: Column(
          children: [
            Text(
              day.tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            /* Text(
              '$date',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
