import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/common_variables.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controllers/show_tabs_controller.dart';

class ShowTabsView extends GetView<ShowTabsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 254.0,
              height: 247.0,
              child: Image.asset(
                'assets/images/subtract.png',
              ),
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    // reverse: true,
                    onPageChanged: ((value) {
                      controller.pageIndex.value = value;
                    }),
                    controller: controller.pageController,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          buildImageTab(context),
                          SizedBox(height: 60),
                          buildText(context, 'tabPay'.tr),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          buildImageTab(context),
                          SizedBox(height: 60),
                          buildText(context, 'tabKnowResult'.tr),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          buildImageTab(context),
                          SizedBox(height: 60),
                          buildText(context, 'tabKnowDates'.tr),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    trailing: Obx(
                      () => DotsIndicator(
                        dotsCount: 3,
                        position: controller.pageIndex.value,
                        decorator: DotsDecorator(
                          color: Colors.white,
                          activeColor: Theme.of(context).primaryColorLight,
                          size: const Size.square(9.0),
                          activeSize: const Size(20.0, 11.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onTap: (value) {
                          controller.pageController.jumpToPage(value.toInt());
                        },
                      ),
                    ),
                    leading: SizedBox(
                      width: 120,
                      child: BasicButton(
                        label: 'next'.tr,
                        verticalPadding: 8.0,
                        fontSize: 18.0,
                        onPresed: () {
                          CommonVariables.userData.write('firstLaunch', false);
                          Get.offNamed(Routes.LOGIN);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageTab(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
        child: Image.asset(
          'assets/images/ind${controller.pageIndex.value}.png',
          height: 225,
        ),
      ),
    );
  }

  Widget buildText(BuildContext context, String text) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 40),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
