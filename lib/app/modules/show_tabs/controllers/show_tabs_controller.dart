import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShowTabsController extends GetxController {
  PageController pageController = PageController();
  var pageIndex = 0.obs;

   void onpageChanged(int value) {
   
      pageIndex.value = value;
      
 
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
