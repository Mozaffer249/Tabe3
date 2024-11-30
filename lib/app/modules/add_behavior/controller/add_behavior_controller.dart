import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tabee3_flutter/app/providers/student_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class AddBehaviorController extends GetxController{

  final _isSubmitting = false.obs;
  bool get isSubmitting => _isSubmitting.value;
   final TextEditingController bodyController = TextEditingController();

     List<int> _behaviorerIds = [];
  List<int> get behaviorerIds => _behaviorerIds;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null)
      {
        _behaviorerIds =Get.arguments;
        print(_behaviorerIds.length);

      }

  }

  Future<void> addBehavior({required int student_Id,required bool isLast}) async {

    final request = <String, dynamic>{
      "student_id": student_Id,
      "behavior":bodyController.text
    };
    _isSubmitting(true);
      final result = await StudentsProvider.addBehavior(request);
      result.fold(
            (l) {
              if(isLast)
                {
                  _isSubmitting(false);
                  Get.back();
                  showSnackbar(title: "Success".tr, message: "Behavior Added Succesfully".tr);
                }
               } ,
            (r) {
      if(isLast)
      {
              _isSubmitting(false);
              showSnackbar(title: 'Error'.tr, message: r);
              print(r);
            }}
      );
    }

}