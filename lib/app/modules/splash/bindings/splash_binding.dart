import 'package:get/get.dart';
import 'package:tabee3_flutter/app/controllers/settings_controller.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(),);

    Get.put(AuthController(), permanent: true);
    Get.put(SettingsController(), permanent: true);
  }
}
