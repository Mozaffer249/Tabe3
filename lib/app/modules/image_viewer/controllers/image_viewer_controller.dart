import 'package:get/get.dart';

class ImageViewerController extends GetxController {
  late String title;
  late String imageUrl;

  @override
  void onInit() {
    super.onInit();
    imageUrl =
        Get.arguments ?? 'https://dummyimage.com/640x360/fff/aaa';
    title = Get.arguments ?? 'Viewer';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
