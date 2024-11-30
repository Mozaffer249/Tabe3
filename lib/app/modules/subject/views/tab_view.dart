import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/utils.dart';
import 'package:tabee3_flutter/app/data/common/basic_drawer.dart';
import 'package:table_calendar/table_calendar.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with TickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: BasicDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned(
              top: 102,
              left: 10,
              right: 10,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Container(
                        height: 120,
                        width: 360,
                        decoration: BoxDecoration(
                          color: Color(0xff00CDDA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "physics".tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            TabBar(
                              controller: tabController,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white,
                              indicatorColor: Colors.white,
                              indicatorWeight: 5,
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
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      color: Colors.white,
                      height: 330,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                buildstudy("study"),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Container(
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE0E0E0),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                TableCalendar(
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: DateTime.now(),
                                  headerStyle: HeaderStyle(
                                    titleCentered: true,
                                    formatButtonVisible: false,
                                  ),
                                  rowHeight: screenHeight * 0.06,
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.026,
                                          width: screenWidth * 0.05,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.005,
                                        ),
                                        Text("attended".tr),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.026,
                                          width: screenWidth * 0.05,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.005,
                                        ),
                                        Text("didNotAttend".tr),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.026,
                                          width: screenWidth * 0.05,
                                          decoration: BoxDecoration(
                                            color: Color(0xff00CDDA),
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.005,
                                        ),
                                        Text("vacation".tr),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
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
                                InkWell(
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
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 150,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset("assets/images/atom1.png"),
              ),
            ),
            Positioned(
              top: 163,
              left: 16,
              child: Container(
                height: 80,
                width: 80,
                child: Image.asset("assets/images/Ellipse5.png"),
              ),
            ),
            // BasicAppBar(title: "physics"),

            /*  SizedBox(
              height: 120.0,
              child: Stack(
                children: [
                  AppBar(
                    leading: Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            Positioned(
                              top: 2,
                              right: 20,
                              child: SizedBox(
                                child: IconButton(
                                  icon: const Icon(Icons.chat),
                                  onPressed: () {
                                    Get.toNamed(Routes.CHAT);
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              left: 25,
                              child: SizedBox(
                                width: 35,
                                child: IconButton(
                                  icon: const Icon(Icons.menu),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  tooltip: MaterialLocalizations.of(context)
                                      .openAppDrawerTooltip,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    title: Text(
                      "physics".tr,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                    toolbarHeight: 110.0,
                    backgroundColor: backgroundAppColor,
                    flexibleSpace: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset('assets/images/imageAppBar.png'),
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    right: 260,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.HOME);
                      },
                    ),
                  ),
                ],
              ),
            ),
           */
          ],
        ),
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

  Row buildstudy(
    String name,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            name.tr,
            style: TextStyle(color: Color(0xff585858), fontSize: 15),
          ),
        ),
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Color(0xff00CDDA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset("assets/images/Vector2.png"),
        ),
      ],
    );
  }
}
