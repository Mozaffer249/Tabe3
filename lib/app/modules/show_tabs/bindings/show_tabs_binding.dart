import 'package:get/get.dart';

import '../controllers/show_tabs_controller.dart';

class ShowTabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowTabsController>(
      () => ShowTabsController(),
    );
  }
}
