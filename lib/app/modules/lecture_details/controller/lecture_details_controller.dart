import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/lesson_model.dart';

class LecureDetailsController extends GetxController{

  late   Lesson  lesson;

   String fileType="";
   RxString lessonBase64 ="".obs;

  dynamic argument=Get.arguments;
  var imageBytes  ;
  var imageProvider  ;
@override
  void onInit() {
    super.onInit();
    if(Get.arguments != null)
      {
        lesson =argument[0];
        fileType =argument[1];
        // print(lesson.lesson!.length);
        // print(lesson.lesson!);
      lessonBase64.value =lesson.lesson!;
      }
  }
  @override
  void onClose() {
     super.onClose();
  }
}