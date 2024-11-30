import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/Tests.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';

class TestsController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final _isReLoading = false.obs;
  bool get isReLoading => _isReLoading.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _tests = <Tests>[].obs;
  RxList<Tests> get tests => _tests;

  final Rxn<ClassModel> _selectedClass = Rxn();
  ClassModel? get selectedClass => _selectedClass.value;

  set selectedClass(ClassModel? model) {
    _selectedClass(model);
    getAllTests();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (authController.availableClasses.isNotEmpty) {
      _selectedClass.value = authController.availableClasses.first;
    }
    getAllTests();
  }

  void getAllTests()async{
    _isLoading(true);
    await Future.delayed(Duration(seconds: 2));
    _tests.value.add(
        Tests(
          id:1 ,
          name: "رياضيات",

          ));

    _tests.value.add(
        Tests(
          id:2 ,
          name: "حاسوب",
          classessNames:[ "الاول "],
            date: "15/5/2023"
          ));
          _tests.refresh();
          _isLoading(false);


  }

}