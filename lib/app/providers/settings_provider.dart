import 'package:dartz/dartz.dart';
import 'package:tabee3_flutter/app/config/dio_config.dart';
import 'package:tabee3_flutter/app/data/models/app_info.dart';

class SettingsProvider {
  static Future<Either<AppInfo, String>> getAppInfo() async {
    try {
      var response = await DioClient.DIO_CLIENT.post(
        '/info',
        data: {"params": {}},
      );
      if (response.data.containsKey("error")) {
        return right(response.data['message']);
      }
      final Map<String, dynamic> result = response.data['result'];
      if (result.containsKey('status') && result['status'] == 1) {
        AppInfo appInfo = AppInfo.fromMap(result['result']);
        return left(appInfo);
      } else {
        return right(result['msg']);
      }
    } catch (e) {
      return right('Exception $e');
    }
  }
}
