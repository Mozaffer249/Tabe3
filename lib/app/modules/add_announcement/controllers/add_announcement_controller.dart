// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/announcements_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class AddAnnouncementController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController classes = TextEditingController();

  final HtmlEditorController bodyController = HtmlEditorController();

  final GlobalKey<FormState> formKey = GlobalKey();

  final Rxn<ClassModel> _selectedClass = Rxn();
  ClassModel? get selectedClass => _selectedClass.value;
  set selectedClass(ClassModel? model) => _selectedClass(model);

  final RxList<ClassModel> _selected = <ClassModel>[].obs;
  List<ClassModel> get selected => this._selected.value;
  set selected(value) {
    this._selected.value = value;
    _selected.refresh();
  }

  final _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime model) => _selectedDate(model);



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    if (authController.availableClasses.isNotEmpty) {
      _selectedClass(authController.availableClasses.first);
    }
  }

  Future<void> submit() async {
    final String body = await bodyController.getText();
    final String title = titleController.text.trim();
    final String date = DateFormat('MM/dd/yyyy hh:mm a').format(_selectedDate.value);

    if (body.isEmpty) {
      showSnackbar(
        title: null,
        message: 'Please fill announcement body'.tr,
        isError: true,
      );
      return;
    }
    if (title.isEmpty) {
      showSnackbar(
        title: null,
        message: 'Please fill announcement title'.tr,
        isError: true,
      );
      return;
    }
    if (selected.isEmpty) {
      showSnackbar(
        title: null,
        message: 'Please select class'.tr,
        isError: true,
      );
      return;
    }
    final request = {
      "name": title,
      "date": date,
      "body": body,
      "class_id": selected.map((e) => e.id).toList(),
      "company_id": authController.currentUser!.companyId,
    };


    _isLoading(true);
    final result = await AnnouncementsProvider.addAnnouncement(request);
    _isLoading(false);
    result.fold(
      (l) => Get.back(result: true),
      (r) => showSnackbar(
        title: 'Error'.tr,
        message: r,
        isError: true,
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
