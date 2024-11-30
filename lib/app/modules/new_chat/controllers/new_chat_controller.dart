// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/ViewModel/student_parent_view_model.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/contacts_model.dart';
import 'package:tabee3_flutter/app/data/models/conversation_model.dart';
import 'package:tabee3_flutter/app/data/models/parent_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/contact_provider.dart';
import 'package:tabee3_flutter/app/providers/student_provider.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

class NewChatController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final Rxn<ClassModel> _selectedClass = Rxn<ClassModel>();
  ClassModel? get selectedClass => _selectedClass.value;
  set selectedClass(ClassModel? value) {
    _selectedClass(value);
    getParents();
  }

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxList<Contacts> _contacts = <Contacts>[].obs;
  List<Contacts> get contacts => _contacts.value;

   final  _studentsParent = <StudentParentModel>[].obs;
  RxList<StudentParentModel> get students => _studentsParent;

  final RxList<Parent> _parents = <Parent>[].obs;
  List<Parent> get parents => _parents.value;

  bool _isSelectingActive = false;
  set isSelectingActiveSet(bool value) {_isSelectingActive = value;}
  bool get isSelectingActive => _isSelectingActive;



  final  _reciverIds=<int>[].obs;
  List<int> get reciverIds => _reciverIds;

  @override
  void onInit() {
    super.onInit();
    if (authController.currentUser!.userType == "P") {
      getTeachers();
    } else {
      _selectedClass.value = authController.availableClasses.first;
      getParents();
    }
  }

  Future<void> getTeachers() async {
    _isLoading(true);
    final result =
        await ContactProvider.getContacts(authController.currentUser!.id!);
    _isLoading(false);
    result.fold(
      (l) => _contacts(l),
      (r) => null,
    );
  }

  Future<void> getParents() async {
    _isSelectingActive =false;
    _reciverIds.value.removeRange(0, _reciverIds.length);
    _isLoading(true);
    final result = await StudentsProvider.getClassStudentWithParent(
        _selectedClass.value!.id!);
    _isLoading(false);
    result.fold(
      (l) => _studentsParent(l),
      (r) => null,
    );
  }

  Future<void> onLongTapListItem(int id, bool value) async
  {
    if(!_isSelectingActive ) ;{
    _isSelectingActive=true;
  }
    final index = _studentsParent.value.indexWhere((element) => element.parentId == id);

      _studentsParent.value[index].isSelected = !_studentsParent.value[index].isSelected;

      if ( _studentsParent.value[index].isSelected) {
        _reciverIds.add(id);
      } else {
        _reciverIds.remove(id);
      }
      _studentsParent.refresh();
      _reciverIds.refresh();
      if(_reciverIds.length==0)_isSelectingActive=false;
      print(_reciverIds);

  }

  Future<void>goToMultiMessage()async{
    List<int> receiver =<int>[];

    for(var rec in _reciverIds)
    {
      receiver.add(rec);
    }
    _isSelectingActive =false;
    for(var stu in _studentsParent){
      if(stu.isSelected)
        stu.isSelected=false;
    }
    _reciverIds.removeRange(0,_reciverIds.length);

    Get.toNamed(
      Routes.MULTI_MESSAGE,
      arguments:[receiver,true],
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

  }
}
