import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/student_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class BehaviorController extends GetxController{
  final AuthController authController = Get.find<AuthController>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isSubmitting = false.obs;
  bool get isSubmitting => _isSubmitting.value;

  final _students = <Student>[].obs;
  List<Student> get students => _students.value;

  final Rxn<ClassModel> _selectedClass = Rxn();
  ClassModel? get selectedClass => _selectedClass.value;
  set selectedClass(ClassModel? model) {
    _selectedClass(model);
    getStudents();
  }

  final _behaviorerIds = <int>[].obs;
  List<int> get behaviorerIds => _behaviorerIds.value;

  RxString _behavior =''.obs;
  set behavior(RxString value) {_behavior = value;}
  RxString get behavior => _behavior;

  RxList<String?> _behaviorList=<String>[].obs;
  RxList<String?> get behaviorList => _behaviorList;

  @override
  void onInit() {
    super.onInit();

    if(authController.currentUser!.userType! =="T")
    {
      if (authController.availableClasses.isNotEmpty) {
        _selectedClass.value = authController.availableClasses.first;
      }

      getStudents();
    }
    else if (Get.arguments != null){
      print(Get.arguments);
      getStudentBehavior();
    }
  }


  void filter(String keyword) {
    _students.value = _students.where((element) => element.studentName!.contains(keyword)).toList();
  }

  Future<void> getStudentBehavior() async {

    final request = <String, dynamic>{
      "student_id": Get.arguments,
    };
    _isLoading(true);
    final result = await StudentsProvider.getStudentBehavior(request);
    _isLoading(false);
    result.fold(
          (l) {
            behavior(l['result']);
            final RegExp regExp = RegExp(r"(?<=<br>)(.*?)(?=</span>)");
            final Iterable<RegExpMatch?> matches = regExp.allMatches(l['result']);
            for(var beh in matches.map((match) => match!.group(0)) )
              {
                _behaviorList.value.add(beh);
              }
      },
          (r) => showSnackbar(
        title: 'Error'.tr,
        message: r,
        isError: true,
      ),
    );
  }
  Future<void> getStudents() async {
    _students.clear();
    _isLoading(true);
    final result =
    await StudentsProvider.getStudentsInClass(selectedClass!.id!);
    _isLoading(false);
    result.fold(
          (l) {
        _students(l);
      },
          (r) => showSnackbar(
        title: 'Error'.tr,
        message: r,
        isError: true,
      ),
    );
  }

  Future<void>  toggelBehavior(int id, bool? value) async {
    final index = _students.value.indexWhere((element) => element.studentId == id);

    if (index != -1) {
      _students.value[index].isAbsent = !_students.value[index].isAbsent;
      if (value != null && value) {
        _behaviorerIds.value.add(id);
      } else {
        _behaviorerIds.value.remove(id);
      }
      _students.refresh();
      print(_behaviorerIds);
    }
  }
}
