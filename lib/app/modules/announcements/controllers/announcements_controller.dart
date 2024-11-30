// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/announcement_model.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/announcements_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class AnnouncementsController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isDeleting = false.obs;
  bool get isDeleting => _isDeleting.value;

  final _announcements = <Announcement>[].obs;
  List<Announcement> get announcements => _announcements.value;

  final Rxn<ClassModel> _selectedClass = Rxn();
  ClassModel? get selectedClass => _selectedClass.value;
  set selectedClass(ClassModel? model) {
    _selectedClass(model);
    getAnnouncements();
  }

  late Subject subject;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      subject = Get.arguments;
    } else {}
    if (authController.availableClasses.isNotEmpty) {
      _selectedClass.value = authController.availableClasses.first;
    }
    getAnnouncements();
  }

  Future<void> getAnnouncements() async {
    _isLoading(true);
    final result = await AnnouncementsProvider.getAnnouncements(
      authController.currentUser!.id!,
      selectedClass!.id!,
    );
    _isLoading(false);
    result.fold(
      (l) => _announcements(l),
      (r) => showSnackbar(
        title: 'Error'.tr,
        message: r,
        isError: true,
      ),
    );
  }

  Future<void> deleteAnnouncement(int id) async {
    _isDeleting(true);
    final result = await AnnouncementsProvider.deleteAnnouncement(id);
    _isDeleting(false);
    result.fold(
      (l) => getAnnouncements(),
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
