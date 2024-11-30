import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/subject_card.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controllers/all_subjects_controller.dart';

class AllSubjectsView extends GetView<AllSubjectsController> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   // statusBarColor: Color(0xff00CDDA), // status bar color
    // ));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: controller.subjects.isEmpty
                      ? Center(
                          child: Text(
                            'No Subjects for this student'.tr,
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 110 / 90,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            mainAxisExtent: 110,
                          ),
                          itemCount: controller.subjects.length,
                          itemBuilder: (BuildContext context, int index) {
                            final subject =
                                controller.subjects.elementAt(index);
                            return SubjectCard(
                              name: subject.name!,
                              color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt(),
                              ).withOpacity(1.0),
                              onPressed: () => Get.toNamed(
                                Routes.SUBJECT,
                                arguments: subject,
                              ),
                              image: subject.image!,
                            );
                          },
                        ),
                ),
              ),
            ),
            BasicAppBar(title: "subjects")
          ],
        ),
      ),
    );
  }

  Widget buildTextButton(
      String name, Color color, Function() onpressed, String image) {
    return TextButton(
      onPressed: onpressed,
      child: Container(
        height: 110,
        width: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 228, 227, 227),
              blurRadius: 5.0,
              spreadRadius: 1,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
                child: Image.asset("assets/images/${image}.png")),
            SizedBox(
              height: 10,
            ),
            Text(
              name.tr,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
