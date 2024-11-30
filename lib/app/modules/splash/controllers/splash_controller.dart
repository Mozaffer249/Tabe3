import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/controllers/settings_controller.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class SplashController extends GetxController {
  final count = 0.obs;
   AuthController authController=Get.find<AuthController>();
   SettingsController settingsController=Get.find<SettingsController>();

  // final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    authController.init();
    // getConnectivityType();
    // _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
   }



//   Future<void> getConnectivityType() async {
//     late ConnectivityResult connectivityResult;
//     try {
//       connectivityResult = await (_connectivity.checkConnectivity());
//     } on PlatformException catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//     return _updateState(connectivityResult);
//   }
//
//   _updateState(ConnectivityResult result) async {
//     switch (result) {
//       case ConnectivityResult.wifi:
//        authController.connectionType.value = 1;
//        if(Get.currentRoute==Routes.SPLASH)  {
//          if(authController.connectionType.value ==1 )
//        {
//             settingsController.getAppInfo();
//             authController.init();
//        }
//           print("*******************************************************${authController.connectionType}");
//        }
//
//         break;
//       case ConnectivityResult.mobile:
//         authController.connectionType.value = 2;
//         if(Get.currentRoute==Routes.SPLASH) {
//           if(authController.connectionType.value == 2 )
//           {
//             settingsController.getAppInfo();
//             authController.init();
//           }
//           print("*******************************************************${authController.connectionType}");
//         }
//         break;
//       case ConnectivityResult.none:
//         authController.connectionType.value = 0;
//         print("*******************************************************${authController.connectionType}");
//         break;
//       default:
//         await showSnackbar(
//             title: 'Error', message: 'Failed to get connection type');
//         break;
//     }
//
//   }
//
}