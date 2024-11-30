import 'dart:convert';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/lesson_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/lesson_provider.dart';
import 'package:tabee3_flutter/app/utils/GoogleDrive/GoogleDrive.dart';
 import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:tabee3_flutter/app/utils/file_utils.dart';

class AddLectureController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController lectureNameController = TextEditingController();
  final TextEditingController driverLinkController = TextEditingController();
  final TextEditingController liveLectureLinkController = TextEditingController();
  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController fileNameController = TextEditingController();
  final TextEditingController classes = TextEditingController();

  final drive = GoogleDrive();

  late Subject subject;
    String? fileBase64 ;

  late  String fileType="";

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) {_isLoading = value;}


  RxList<File> _attachedFile = RxList();
  List<File> get attachedFile => _attachedFile.value;

  Rxn<ClassModel> _selecteLectureType= Rxn();
  set selecteLectureType(value) {_selecteLectureType.value = value;}
  ClassModel?  get selecteLectureType => _selecteLectureType.value;

  final Rxn<ClassModel> _selectedClass = Rxn();
  ClassModel? get selectedClass => _selectedClass.value;
  set selectedClass(ClassModel? model) {
    _selectedClass(model);
  }

  final RxList<ClassModel> _selected = <ClassModel>[].obs;
  List<ClassModel> get selected => this._selected.value;
  set selected(value) {this._selected.value = value;_selected.refresh();}

  @override
  void onInit() {
    super.onInit();
    if (authController.availableClasses.isNotEmpty) {
      _selectedClass(authController.availableClasses.first);
    }
    if (Get.arguments != null) {
      subject = Get.arguments;
      subjectNameController.text = subject.name!;
    }
    _selecteLectureType.value=ClassModel(id: 1,name: "رابط بث مباشر");
  }

  void uploadFile() async {
    _attachedFile.removeRange(0, _attachedFile.value.length);
    fileNameController.clear();
    List<PlatformFile>? files=   await getFile(Get.overlayContext!);
    if (files != null) {
      for (var platformFile in files) {
        var file = File(platformFile.path!);
        _attachedFile.add(file);
        fileNameController.text=","+fileNameController.text+file.path.split("/").last.toString();
      }
      print(_attachedFile.length.toString());
    }
  }

  Future<void>uploadToDrive()async{
    if (selected.isEmpty){
      showSnackbar(
        title: null,
        message: 'Select classes'.tr,
        isError: true,
      );
      return;
    }

    if (lectureNameController.text.isEmpty) {
      showSnackbar(
        title: null,
        message: 'Please enter lecture name'.tr,
        isError: true,
      );
      return;
    }
    if (fileNameController.text.trim().isEmpty &&_selecteLectureType.value!.id==2) {
      showSnackbar(
        title: null,
        message: 'Choose Lecture From Files'.tr,
        isError: true,
      );
      return;
    }
    if(liveLectureLinkController.text.trim().isEmpty && _selecteLectureType.value!.id==1){
      showSnackbar(
        title: null,
        message: 'Enter Live Lecture Link'.tr,
        isError: true,
      );
      return;
    }

         _isLoading(true);

    if(_selecteLectureType.value!.id==2){
      final result = await drive.upload(attachedFile,lectureNameController.text);
      driverLinkController.text =  result!;
    }
         // print(driverLinkController.text);
         _isLoading(false);
         for(var selectedClass in _selected)
           submit(
               classId: selectedClass.id!,
               isLast:selectedClass.id! == selected.last.id?true:false
           );
  }
  Future<void> submit({required int classId,required bool isLast}) async {
    final request = <String, dynamic>{
      "teacher_id": authController.currentUser!.id,
      "name": "${lectureNameController.text}",
      "lessonBase54":'',
      "subject_id": subject.id,
      "url":_selecteLectureType.value!.id==1? liveLectureLinkController.text.trim() : driverLinkController.text.trim() ,
      "type":  "url",
      "class_id": classId,
     };
    _isLoading(true);
    final result = await LessonProvider.uploadLesson(request);
    if(isLast){
      _isLoading(false);
      result.fold(
        (l) => Get.back(result: true),
        (r) => Get.showSnackbar(GetSnackBar(
          title: 'Error'.tr,
          message: '$r',
        )),
      );
    }
  }

  RxList<ClassModel> lecturesTypes =<ClassModel>[
    ClassModel(id: 1,name: "رابط بث مباشر"),
    ClassModel(id: 2,name: "تحميل ملف"),
  ].obs;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
