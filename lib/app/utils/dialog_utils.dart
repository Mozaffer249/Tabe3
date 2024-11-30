import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showSnackbar({
  required String? title,
  required String message,
  bool isError = false,
}) async {
  Get.showSnackbar(GetSnackBar(
    message: message,
    title: title,
    isDismissible: true,
    overlayBlur: 2,
    backgroundColor: isError ? Colors.red : Color(0xFF303030),
    snackStyle: SnackStyle.FLOATING,
    duration: Duration(seconds: 2),
  ));
}

Future<T?> showConfirmationDialog<T>({
  String? msg,
  Widget? icon,
  List<Widget>? actions,
  bool dismissible = true,
}) async {
  final result = await Get.defaultDialog<T>(
    radius: 8,
    title: '',
    titleStyle: const TextStyle(
      fontSize: 0,
    ),
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    actions: actions,
    barrierDismissible: dismissible,
    content: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
        Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: icon ??
                      Icon(
                        Icons.warning,
                        color: Colors.white,
                      )),
              SizedBox(height: 20),
              Text(
                msg ?? 'Warning'.tr,
                style: Get.theme.textTheme.titleMedium,
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ],
    ),
  );
  return result;


}

UpdateDialog(){
  showDialog(
    context: Get.context!,
    barrierDismissible: false, // <-- Set this to false.
    builder: (_) => WillPopScope(
      onWillPop: () async => false, // <-- Prevents dialog dismiss on press of back button.
      child: AlertDialog(
        title: Text("Update Message".tr),
        actions: [
          BasicButton(
            onPresed:( )async{
              await  launch("https://play.google.com/store/apps/details?id=com.moggal.tab3");
            },
            label: "Update".tr,


          )
        ],
      ),
    ),
  );
}


enternetConnectioDialog(){
  Get.defaultDialog(
    title: "No internet connection".tr,
    content: Center(child: Icon(Icons.network_check_outlined,size: 28,)),
    textCancel: 'cancel',
    onCancel: () {Get.back();},
  );
}