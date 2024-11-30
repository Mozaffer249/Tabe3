// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/controllers/settings_controller.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/common_variables.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/exams_model.dart';
import 'package:tabee3_flutter/app/data/models/student_announcements_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/announcements_provider.dart';
import 'package:tabee3_flutter/app/providers/home_provider.dart';
import 'package:tabee3_flutter/app/providers/student_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  AuthController authController = Get.find<AuthController>();
  SettingsController settingsController  = Get.find<SettingsController>();

  final students = <Student>[].obs;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  Rxn<ExamModel> examModel = Rxn<ExamModel>();
  Rxn<Student> student = Rxn<Student>();
  Rxn<Subject> subject = Rxn<Subject>();

  final RxList<StudentAnnouncements> _announcements =
      <StudentAnnouncements>[].obs;
  List<StudentAnnouncements> get announcements => this._announcements.value;

  final RxList<Subject> _studentSubjects = <Subject>[].obs;
  List<Subject> get studentSubjects => this._studentSubjects.value;

  final RxBool _isLoadingAnnouncments = false.obs;
  bool get isLoadingAnnouncments => this._isLoadingAnnouncments.value;

  final RxBool _isLoadingStudents = false.obs;
  bool get isLoadingStudents => this._isLoadingStudents.value;

  final RxBool _isLoadingSubjects = false.obs;
  bool get isLoadingSubjects => this._isLoadingSubjects.value;

  @override
  void onInit() async {
    super.onInit();
    if (authController.currentUser!.userType == "P") {
      await getStudnets();
    } else {
      subject.value = authController.teacherSubjects.first;
    }
    getAnnouncments();

    // if(APP_VERSION != settingsController.appInfo!.lastAppVersion)UpdateDialog();
  }

  Future<void> getStudnets() async {
    _isLoadingStudents(true);
    final result = await HomeProvider.getStudents(authController.currentUser!.id!);
    _isLoadingStudents(false);
    result.fold(
      (List<Student>? l)async {
        this.students.value = l!;
        if (l.isNotEmpty) {authController.student_id.value = l.first.studentId!;
       await   selectStudent(l.first);
        }
      },
      (String r) => null,
    );
  }

  Future<void> getAnnouncments() async {
    _isLoadingAnnouncments(true);
    final result = await AnnouncementsProvider.getGeneralAnnouncements(
      authController.currentUser!.id,
      student.value == null ? null : student.value!.studentId,
    );
    _isLoadingAnnouncments(false);
    result.fold(
      (List<StudentAnnouncements>? l) {
        _announcements.value = l!;
      },
      (String r) => null,
    );
  }

  Future<void> selectStudent(Student value) async {
    student.value = value;
    _isLoadingSubjects(true);
  await  getAnnouncments();
    final result = await StudentsProvider.getStudentSubject(value.studentId!);
    _isLoadingSubjects(false);
    result.fold((l) => _studentSubjects(l), (r) => null);
  }

  Future<void> selectClass(Subject value) async {
    subject.value = value;
  }

  @override
  void onClose() {}
}
