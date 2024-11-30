import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/app_info.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/settings_provider.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

class SettingsController extends GetxController {

  // AuthController authController=Get.find<AuthController>();
  AuthController authController=Get.find<AuthController>();

  final Rxn<AppInfo> _appInfo = Rxn<AppInfo>();
  AppInfo? get appInfo => this._appInfo.value;

  @override
  void onInit() {
    super.onInit();
    if(authController.connectionType.value != 0 && authController.connectionType.value !=3) getAppInfo();
   }

  Future<void> getAppInfo() async {
       final result = await SettingsProvider.getAppInfo();
      result.fold((l) => _appInfo(l), (r) => null);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
